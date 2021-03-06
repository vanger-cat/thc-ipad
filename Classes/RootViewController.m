//
//  RootViewController.m
//  thc-ipad
//
//  Created by Dmitry Volkov on 12.11.10.
//  Copyright 2010 Magik Ink. All rights reserved.
//

#import "RootViewController.h"
#import "Element.h"
#import "THCColors.h"
#import "THCFonts.h"
#import "THCUILabel.h"
#import "THCUILink.h"
#import "THCUIComponentsUtils.h"
#import "Utils.h"
#import "DropboxSDK.h"
#import "THCUIImage.h"

@implementation RootViewController

@synthesize scrollView;
@synthesize currentTextViewWithElement;
@synthesize dropboxController;
@synthesize componentsFactory;
@synthesize elementManager;

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
	[self showElements:[elementManager copyElementsArray] 
				inView:self.scrollView.spaceView];
	[self.scrollView scrollRectToVisible:center animated:NO];
	
	//[self addRandomLabels:1000];
	if (!dropboxController)
		dropboxController = [[DropboxController alloc] init];

//	//TODO: delete
//	{
//		id<ElementInterface> element = [elementManager savedElementWithText:@"vanger.JPG" 
//																	atPoint:CGPointMake(100, 100)];
//		[THCUIImage createInView:self.scrollView.spaceView withElement:element];
//		[elementManager save];
//	}
//	//TODO: delete
//	{
//		id<ElementInterface> element = [elementManager savedElementWithText:@"http://ya.ru" 
//																	atPoint:CGPointMake(10, 10)];
//		[THCUILink createInView:self.scrollView.spaceView withElement:element];
//		[elementManager save];
//	}
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

#pragma mark initial loading of elements

- (void)showElements:(NSArray *)elements inView:(UIView *)view {
	Element *element;
	for (element in elements) {
		[componentsFactory addComponentToView:view withElement:element];
	}
}

#pragma mark Space gestures

- (UIGestureRecognizer *)newGestureToCreateTextView {
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self 
																		  action:@selector(createNewTextViewGesureRecognized:)];
	tap.numberOfTapsRequired = 2;
	return tap;
}

- (void)createNewTextViewGesureRecognized:(UIGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateRecognized) {
		CGPoint pointForTextView = [gesture locationInView:self.scrollView.spaceView];
		id<ElementInterface> element = [elementManager savedElementWithText:@"" 
																	atPoint:pointForTextView];
		
		element.type = kTypeLabel;
		
		[self createTextViewAtPoint:pointForTextView atView:self.scrollView.spaceView withElement:element];
	}
}
	
- (void)createTextViewAtPoint:(CGPoint)pointForTextView atView:(UIView *)view withElement:(id<ElementInterface>)element {
	THCUITextView *textViewWithElement = [THCUITextView createInView:view
															  withElement:element];
	
	[THCScrollView changePositionWithAdjustmentByGridOfComponent:textViewWithElement 
														 toPoint:pointForTextView 
														animated:YES];
	
	[textViewWithElement saveComponentStateToElement];
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
	self.currentTextViewWithElement = (THCUITextView *) [THCUIComponentsUtils getBasicComponentOf:textView];
	UIGestureRecognizer *gestureToCancelEditing = [self newGestureToCancelEditing];
	[self.scrollView addGestureRecognizer:gestureToCancelEditing];
	[gestureToCancelEditing release];
	
	return YES; 
}

- (void)textViewDidEndEditing:(UITextView *)textView {
	THCUITextView *textViewWithElement = (THCUITextView *) textView.superview;
	
	[self createComponentIfTextViewIsNotEmpty:textViewWithElement];
	
	[textViewWithElement removeFromSuperview];
}

- (void)createComponentIfTextViewIsNotEmpty:(THCUITextView *)textViewWithElement {
	if ([textViewWithElement hasText]) {
		[self createComponentFromTextView:textViewWithElement];
		NSLog(@"Added label with text: '%@'", textViewWithElement.text);
	} else {
		[elementManager deleteElement:textViewWithElement.element];
		NSLog(@"deleted empty element");
	}

}

- (void)createComponentFromTextView:(THCUITextView *)textViewWithElement {
	CGPoint pointForComponent = CGPointMake(textViewWithElement.x, textViewWithElement.y);
	
	[textViewWithElement saveComponentStateToElement];
	id<ElementInterface> element = textViewWithElement.element;
	element.type = textViewWithElement.typeOfEditedComponent;
	
	THCUIComponentAbstract *component = (THCUIComponentAbstract *)[self.componentsFactory addComponentToView:textViewWithElement.superview 
																								 withElement:element];
		
	[THCScrollView changePositionWithAdjustmentByGridOfComponent:component
														 toPoint:pointForComponent  
														animated:YES];	
}

- (void)textViewDidChange:(UITextView *)textView {
	THCUITextView *textViewWithElement = (THCUITextView *) textView.superview;
	textViewWithElement.text = textView.text;
}

#pragma mark THCScrollViewDelegate

- (void)scrollView:(THCScrollView *)scrollView touchEnded:(UIView *)draggedObject {
	THCUIComponentAbstract *componentWithElement = (THCUIComponentAbstract *)draggedObject;
	[componentWithElement saveComponentStateToElement];

	NSLog(@"Component dragged to %f, %f", componentWithElement.x, componentWithElement.y);
}

#pragma mark Dropbox
- (IBAction)showDropboxLoginController:(id)sender {
	DBLoginController* controller = [[DBLoginController new] autorelease];
	[controller presentFromController:self];
}

@end
