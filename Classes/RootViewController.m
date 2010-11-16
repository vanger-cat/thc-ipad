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

@interface RootViewController (PrivateMethods)

- (void)addTextNoteLabelAtPoint:(CGPoint)point 
							withText:(NSString *)text 
							  toView:(UIView *)aView
						  andToArray:(NSMutableArray *)anArray 
						 withElement:(Element *)element;

@end


#import "Element.h"
#import "ElementManager.h"

@implementation RootViewController

@synthesize textNotes;
@synthesize scrollView;

const CGFloat kTextAndLabelXDifference = 8;
const CGFloat kTextAndLabelYDifference = 8;
const CGFloat kTextNoteWidth = 150;
const CGFloat kTextNoteHeight = 100;
const CGFloat kTextNoteHeightMax = 9999;

- (void)showElements:(NSArray *)elements inView:(UIView *)view andAddToArray:(NSMutableArray *)array{
	Element *element;
	for (element in elements) {
		[self addTextNoteLabelAtPoint:CGPointMake([element.x floatValue], [element.y floatValue]) 
							 withText:element.text 
							   toView:view 
						   andToArray:array 
						  withElement:element];
	}
}

- (void)addRandomLabels:(int)count {
	// Add test text notes
	for (int i = 0; i < count; i++) {
		CGPoint pointForLabel = CGPointMake(randomIntValueFrom(0, self.scrollView.contentSize.width),
											randomIntValueFrom(0, self.scrollView.contentSize.height));
		[self addTextNoteLabelAtPoint:pointForLabel
							 withText:@"Поддержать большое количество записей."
							   toView:self.scrollView 
						   andToArray:self.textNotes 
						  withElement:NULL];
	}
}

#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	textNotes = [[NSMutableArray alloc] init];

	UITapGestureRecognizer *doubleTap = [self newDoubleTapGestureForSpace];
	[self.scrollView addGestureRecognizer:doubleTap];
	[doubleTap release];
	
	self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 5, self.scrollView.frame.size.height * 5);
	self.scrollView.thcDelegate = self;
	
	CGRect center = CGRectMake(self.scrollView.contentSize.width / 2, self.scrollView.contentSize.height / 2, 1, 1);
	[self showElements:[[ElementManager sharedInstance] copyElementsArray] 
				inView:self.scrollView
		 andAddToArray:self.textNotes];
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
	[textNotes release];
	[scrollView release];
    [super dealloc];
}

#pragma mark Сreation of text boxes and labels

- (UITextView *)addTextViewWithRect:(CGRect)rect withText:(NSString *)text toView:(UIView *)aView withElement:(Element *)element {
	THCTextViewWithElement *textView = [[THCTextViewWithElement alloc] init];
	textView.element = element;
	
	textView.contentInset = UIEdgeInsetsZero;
	textView.text = text;
	textView.delegate = self;
	textView.backgroundColor = [UIColor colorForTextNoteBackground];
	textView.textColor = [UIColor whiteColor];
	textView.font = [UIFont fontForTextNote];
	textView.editable = YES;
	textView.scrollEnabled = YES;
	[aView addSubview:textView];
	textView.frame = rect;
	[textView release];

	[textView becomeFirstResponder];
	
	return textView;
}

- (void)addTextNoteLabelAtPoint:(CGPoint)point withText:(NSString *)text toView:(UIView *)aView andToArray:(NSMutableArray *)anArray withElement:(Element *)element {
	CGSize size = [text sizeWithFont:[UIFont fontForTextNote] constrainedToSize:CGSizeMake(kTextNoteWidth, kTextNoteHeightMax)];
	THCLabelWithElement *label = [[THCLabelWithElement alloc] initWithFrame:CGRectMake(point.x, point.y, kTextNoteWidth, size.height)];
	label.element = element;
	
	label.userInteractionEnabled = YES;
	label.numberOfLines = 0;
	label.text = text;
	label.backgroundColor = [UIColor colorForTextNoteBackground];
	label.textColor = [UIColor whiteColor];
	label.font = [UIFont fontForTextNote];
	
	[aView addSubview:label];
	[anArray addObject:label];
	
	UITapGestureRecognizer *doubleTap = [self newDoubleTapGestureForLabel];
	[label addGestureRecognizer:doubleTap];
	[doubleTap release];
	
	[label release];
}	

- (void)removeFromSuperviewLabel:(UILabel *)label andFromArray:(NSMutableArray *)array {
	[label removeFromSuperview];
	[array removeObject:label];
}

#pragma mark TextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
}

- (void)textViewDidEndEditing:(UITextView *)textView {
	// Create new UILabel
	CGPoint pointForLabel = CGPointMake(textView.frame.origin.x + kTextAndLabelXDifference,
								textView.frame.origin.y + kTextAndLabelYDifference);
	
	THCTextViewWithElement *textViewWithElement = (THCTextViewWithElement *) textView;
	Element *element;
	if (textViewWithElement.element){
		element = textViewWithElement.element;
		[[ElementManager sharedInstance] saveElement:element 
											withText:textViewWithElement.text 
											 atPoint:textViewWithElement.frame.origin];
	} else {
		element = [[ElementManager sharedInstance] newSavedElementWithText:textView.text 
																			atPoint:textView.frame.origin];
	}

	[self addTextNoteLabelAtPoint:pointForLabel 
						 withText:textView.text
						   toView:self.scrollView 
					   andToArray:textNotes 
					  withElement:element];
	
	[element release];
	
	[textView removeFromSuperview];
}

#pragma mark Label gestures

- (UITapGestureRecognizer *)newDoubleTapGestureForLabel {
	UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelDoubleTapped:)];
	doubleTap.numberOfTapsRequired = 2;
	return doubleTap;
}

- (void)labelDoubleTapped:(UITapGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateRecognized) {
		THCLabelWithElement *labelWithElement = (THCLabelWithElement *)gesture.view;
		[self removeFromSuperviewLabel:labelWithElement andFromArray:textNotes];

		CGRect textViewRect = CGRectMake(labelWithElement.frame.origin.x - kTextAndLabelXDifference,
										 labelWithElement.frame.origin.y - kTextAndLabelYDifference,
										 kTextNoteWidth,
										 kTextNoteHeight);
		
		[self addTextViewWithRect:textViewRect withText:labelWithElement.text toView:self.scrollView withElement:labelWithElement.element];
	}
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
		CGPoint location = [gesture locationInView:self.scrollView];
		CGRect textViewRect = CGRectMake(location.x,
										 location.y,
										 kTextNoteWidth,
										 kTextNoteHeight);
		[self addTextViewWithRect:textViewRect withText:@"" toView:self.scrollView withElement:NULL];
	}
}

#pragma mark THCScrollViewDelegate

- (void)scrollView:(THCScrollView *)scrollView touchEnded:(UIView *)draggedObject {
	THCLabelWithElement *labelWithElement = (THCLabelWithElement *)draggedObject;
	[[ElementManager sharedInstance] saveElement:labelWithElement.element
										withText:labelWithElement.text 
										 atPoint:labelWithElement.frame.origin];
}

@end
