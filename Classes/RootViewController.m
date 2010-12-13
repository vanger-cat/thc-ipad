//
//  RootViewController.m
//  thc-ipad
//
//  Created by Dmitry Volkov on 12.11.10.
//  Copyright 2010 Magik Ink. All rights reserved.
//

#import "RootViewController.h"
#import "Element.h"
#import "ElementManager.h"
#import "THCColors.h"
#import "THCFonts.h"
#import "THCLabelWithElement.h"
#import "THCUIComponentsUtils.h"
#import "Utils.h"
#import "DropboxSDK.h"

@implementation RootViewController

@synthesize scrollView;
@synthesize currentTextViewWithElement;
@synthesize dropboxController;

- (void)showElements:(NSArray *)elements inView:(UIView *)view {
	Element *element;
	for (element in elements) {
		[THCLabelWithElement addLabelToView:view
								withElement:element 
							   withDelegate:self];
	}
}

#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	UIGestureRecognizer *gestureToCreateTextView = [self newGestureToCreateTextView];
	[self.scrollView addGestureRecognizer:gestureToCreateTextView];
	[gestureToCreateTextView release];
	
	CGFloat widthOfContentViewSquare = MAX(self.scrollView.frame.size.width, self.scrollView.frame.size.height) * 2;
	self.scrollView.contentSize = CGSizeMake(widthOfContentViewSquare, widthOfContentViewSquare);
	self.scrollView.delegate = self.scrollView;
	self.scrollView.thcDelegate = self;
	self.scrollView.canCancelContentTouches = YES;
	
	CGRect center = CGRectMake(self.scrollView.contentSize.width / 2, self.scrollView.contentSize.height / 2, 1, 1);
	[self showElements:[[ElementManager sharedInstance] copyElementsArray] 
				inView:self.scrollView.spaceView];
	[self.scrollView scrollRectToVisible:center animated:NO];
	
	//[self addRandomLabels:1000];
	if (!dropboxController)
		dropboxController = [[DropboxController alloc] init];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[scrollView release];
	[dropboxController release];
    [super dealloc];
}

#pragma mark Space gestures

- (UIGestureRecognizer *)newGestureToCreateTextView {
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self 
																		  action:@selector(createTextView:)];
	tap.numberOfTapsRequired = 2;
	return tap;
}

- (void)createTextView:(UIGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateRecognized) {
		CGPoint location = [gesture locationInView:self.scrollView.spaceView];
		CGPoint point = CGPointMake(location.x, location.y);
		THCTextViewWithElement *textViewWithElement = [THCTextViewWithElement addTextViewToView:self.scrollView.spaceView 
																					withElement:NULL 
																				   withDelegate:self];
		
		[THCScrollView changePositionWithAdjustmentByGridOfComponent:textViewWithElement 
															 toPoint:CGPointMake(point.x, point.y) 
															animated:YES];	
	}
}

- (UITapGestureRecognizer *)newGestureToCancelEditing {
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self 
																		  action:@selector(cancelEditing:)];
	tap.numberOfTapsRequired = 1;
	return tap;
}

- (void)cancelEditing:(UIGestureRecognizer *)gesture {
	[self.scrollView removeGestureRecognizer:gesture];
	[self.currentTextViewWithElement completeEditing];
	self.currentTextViewWithElement = NULL;
}



#pragma mark TextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
	self.currentTextViewWithElement = (THCTextViewWithElement *) [THCUIComponentsUtils getBasicComponentOf:textView];
	UIGestureRecognizer *gestureToCancelEditing = [self newGestureToCancelEditing];
	[self.scrollView addGestureRecognizer:gestureToCancelEditing];
	[gestureToCancelEditing release];
	
	return YES; 
}

- (void)textViewDidEndEditing:(UITextView *)textView {
	THCTextViewWithElement *textViewWithElement = (THCTextViewWithElement *) textView.superview;
	
	if ([textView hasText]) {
			//???: why i need "- kBorderWidth" here???
		CGPoint pointForLabel = CGPointMake(textViewWithElement.x - kBorderWidth, 
											textViewWithElement.y - kBorderWidth);

		[textViewWithElement saveComponentStateToElement];
		id<ElementInterface> element;
		if (textViewWithElement.element){
			element = textViewWithElement.element;
			[[ElementManager sharedInstance] save];
		} else {
			element = [[ElementManager sharedInstance] savedElementWithText:textViewWithElement.text 
																	atPoint:pointForLabel];
		}
		
		THCLabelWithElement *labelWithElement = [THCLabelWithElement addLabelToView:textViewWithElement.superview
																		withElement:element 
																	   withDelegate:self];
		
		[THCScrollView changePositionWithAdjustmentByGridOfComponent:labelWithElement 
															 toPoint:pointForLabel  
															animated:YES];
	}
	
	[textViewWithElement removeFromSuperview];
}

- (void)textViewDidChange:(UITextView *)textView {
	THCTextViewWithElement *textViewWithElement = (THCTextViewWithElement *) textView.superview;
	textViewWithElement.text = textView.text;
}

#pragma mark THCScrollViewDelegate

- (void)scrollView:(THCScrollView *)scrollView touchEnded:(UIView *)draggedObject {
	THCUIComponentAbstract *componentWithElement = (THCUIComponentAbstract *)draggedObject;
	[componentWithElement saveComponentStateToElement];
	[[ElementManager sharedInstance] save];
	 //Element:componentWithElement.element
//										withText:componentWithElement.text 
//										 atPoint:componentWithElement.frame.origin];

	NSLog(@"Component dragged to %f, %f", componentWithElement.x, componentWithElement.y);
}

#pragma mark Dropbox
- (IBAction)showDropboxLoginController:(id)sender {
	DBLoginController* controller = [[DBLoginController new] autorelease];
	[controller presentFromController:self];
}

@end
