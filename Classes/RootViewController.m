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

@implementation RootViewController

@synthesize scrollView;

- (void)showElements:(NSArray *)elements inView:(UIView *)view {
	Element *element;
	for (element in elements) {
		[THCLabelWithElement addLabelAtPoint:CGPointMake([element.x floatValue], [element.y floatValue]) 
										withText:element.text 
										  toView:view 
									 withElement:element 
								withDelegate:self];
	}
}

- (void)addRandomLabels:(int)count {
	// Add test text notes
	for (int i = 0; i < count; i++) {
		CGPoint pointForLabel = CGPointMake(randomIntValueFrom(0, self.scrollView.contentSize.width),
											randomIntValueFrom(0, self.scrollView.contentSize.height));
		[THCLabelWithElement addLabelAtPoint:pointForLabel
									withText:@"Поддержать большое количество записей."
									  toView:self.scrollView.spaceView
								 withElement:NULL 
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
		CGRect textViewRect = CGRectMake(location.x,
										 location.y,
										 kTextNoteWidth,
										 kTextNoteHeight);
		[THCTextViewWithElement addTextViewWithRect:textViewRect 
										   withText:@"" 
											 toView:self.scrollView.spaceView 
										withElement:NULL 
									   withDelegate:self];
	}
}

#pragma mark TextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView {
	if ([textView hasText]) {
			// Create new UILabel
		CGPoint pointForLabel = CGPointMake(textView.frame.origin.x + kTextAndLabelXDifference,
											textView.frame.origin.y + kTextAndLabelYDifference);
		
		THCTextViewWithElement *textViewWithElement = (THCTextViewWithElement *) textView;
		[textViewWithElement saveComponentStateToElement];
		Element *element;
		if (textViewWithElement.element){
			element = textViewWithElement.element;
			[[ElementManager sharedInstance] save];
		} else {
			element = [[ElementManager sharedInstance] newSavedElementWithText:textView.text 
																	   atPoint:textView.frame.origin];
		}
		
		[THCLabelWithElement addLabelAtPoint:pointForLabel 
									withText:textView.text
									  toView:textView.superview
								 withElement:element 
								withDelegate:self];
		
		[element release];
	}
	
	[textView removeFromSuperview];
}

- (void)textViewDidChange:(UITextView *)textView {
	[THCTextViewWithElement resizeTextView:textView];
}

#pragma mark THCScrollViewDelegate

- (void)scrollView:(THCScrollView *)scrollView touchEnded:(UIView *)draggedObject {
	THCLabelWithElement *labelWithElement = (THCLabelWithElement *)draggedObject;
	[[ElementManager sharedInstance] saveElement:labelWithElement.element
										withText:labelWithElement.text 
										 atPoint:labelWithElement.frame.origin];
	}

@end
