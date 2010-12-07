//
//  RootViewController.m
//  thc-ipad
//
//  Created by Dmitry Volkov on 12.11.10.
//  Copyright 2010 Magik Ink. All rights reserved.
//

#import "RootViewController.h"
#import "THCColors.h"
#import "THCFonts.h"
#import "THCLabelWithElement.h"
#import "THCTextViewWithElement.h"
#import "Utils.h"
#import "Element.h"
#import "ElementManager.h"
#import "THCUIComponentsUtils.h"

@implementation RootViewController

@synthesize scrollView;

- (void)showElements:(NSArray *)elements inView:(UIView *)view {
	Element *element;
	for (element in elements) {
		[THCLabelWithElement addLabelAtPoint:CGPointMake([element.x floatValue], [element.y floatValue]) 
										  toView:view 
									 withElement:element 
								withDelegate:self];
	}
}

#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	UITapGestureRecognizer *doubleTap = [self newDoubleTapGestureForSpace];
	[self.scrollView addGestureRecognizer:doubleTap];
	[doubleTap release];
	
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
    [super dealloc];
}

#pragma mark Space gestures

- (UITapGestureRecognizer *)newDoubleTapGestureForSpace {
	UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self 
																				action:@selector(spaceDoubleTapped:)];
	doubleTap.numberOfTapsRequired = 2;
	return doubleTap;
}

- (void)spaceDoubleTapped:(UITapGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateRecognized) {
		CGPoint location = [gesture locationInView:self.scrollView.spaceView];
		CGPoint point = CGPointMake(location.x,
									location.y);
		[THCTextViewWithElement addTextViewAtPoint:point 
											toView:self.scrollView.spaceView 
									   withElement:NULL 
									  withDelegate:self];
	}
}

#pragma mark TextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView {
	THCTextViewWithElement *textViewWithElement = (THCTextViewWithElement *) textView.superview;
	
	if ([textView hasText]) {
		CGRect rectOfTextViewInSpace = [THCUIComponentsUtils getRectInSuperSuperViewOfView:textView];
		CGPoint pointForLabel = CGPointMake(rectOfTextViewInSpace.origin.x, 
											rectOfTextViewInSpace.origin.y);

		[textViewWithElement saveComponentStateToElement];
		Element *element;
		if (textViewWithElement.element){
			element = textViewWithElement.element;
			[[ElementManager sharedInstance] save];
		} else {
			element = [[ElementManager sharedInstance] savedElementWithText:textViewWithElement.text 
																	atPoint:pointForLabel];
		}
		
		[THCLabelWithElement addLabelAtPoint:pointForLabel 
									  toView:textViewWithElement.superview
								 withElement:element 
								withDelegate:self];
		
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

@end
