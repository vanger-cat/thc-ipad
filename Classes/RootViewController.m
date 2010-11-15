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
#import "Utils.h"
#import "Element.h"
#import "ElementManager.h"

@interface RootViewController (PrivateMethods)

@end

@implementation RootViewController

@synthesize textNotes;
@synthesize scrollView;

const CGFloat kTextAndLabelXDifference = 8;
const CGFloat kTextAndLabelYDifference = 8;
const CGFloat kTextNoteWidth = 150;
const CGFloat kTextNoteHeight = 100;
const CGFloat kTextNoteHeightMax = 9999;

- (void)addRandomLabels:(int)count {
	// Add test text notes
	for (int i = 0; i < count; i++) {
		CGPoint pointForLabel = CGPointMake(randomIntValueFrom(0, self.scrollView.contentSize.width),
											randomIntValueFrom(0, self.scrollView.contentSize.height));
		UILabel *label = [self addTextNoteLabelAtPoint:pointForLabel
											  withText:@"Поддержать большое количество записей."
												toView:self.scrollView];
		
		UITapGestureRecognizer *doubleTap = [self newDoubleTapGestureForLabel];
		[label addGestureRecognizer:[self newDoubleTapGestureForLabel]];
		[doubleTap release];
	}
}

#pragma mark View lifecycle

- (void)showElements:(NSArray *)elements inView:(UIView *)aView andAddToArray:(NSMutableArray *)array{
	Element *element;
	for (element in elements) {
		UILabel *label = [self addTextNoteLabelAtPoint:CGPointMake([element.x floatValue], [element.y floatValue]) 
							 withText:element.text 
							   toView:aView];
		[array addObject:label];
		
		UITapGestureRecognizer *doubleTap = [self newDoubleTapGestureForLabel];
		[label addGestureRecognizer:doubleTap];
		[doubleTap release];
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];

	textNotes = [[NSMutableArray alloc] init];

	UITapGestureRecognizer *doubleTap = [self newDoubleTapGestureForSpace];
	[self.scrollView addGestureRecognizer:doubleTap];
	[doubleTap release];
	
	self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 2, self.scrollView.frame.size.height * 2);
	self.scrollView.delegate = self.scrollView;
	
	CGRect center = CGRectMake(self.scrollView.contentSize.width / 2, self.scrollView.contentSize.height / 2, 1, 1);
	[self.scrollView scrollRectToVisible:center animated:NO];
	
	//[self addRandomLabels:1000];

	[self showElements:[[ElementManager sharedInstance] copyElementsArray] 
				inView:self.scrollView.spaceView
		 andAddToArray:self.textNotes];
	[self.scrollView scrollRectToVisible:center animated:NO];
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

#pragma mark Creation of text boxes and labels

- (UITextView *)addTextViewWithRect:(CGRect)rect withText:(NSString *)text toView:(UIView *)aView {
	UITextView *textView = [[UITextView alloc] init];
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

- (UILabel *)addTextNoteLabelAtPoint:(CGPoint)point withText:(NSString *)text toView:(UIView *)aView {
	CGSize size = [text sizeWithFont:[UIFont fontForTextNote] constrainedToSize:CGSizeMake(kTextNoteWidth, kTextNoteHeightMax)];
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(point.x, point.y, kTextNoteWidth, size.height)];
	label.userInteractionEnabled = YES;
	label.numberOfLines = 0;
	label.text = text;
	label.backgroundColor = [UIColor colorForTextNoteBackground];
	label.textColor = [UIColor whiteColor];
	label.font = [UIFont fontForTextNote];
	[aView addSubview:label];
	[label release];
	return label;
}

- (void)removeFromSuperviewLabel:(UILabel *)label andFromArray:(NSMutableArray *)array {
	[label removeFromSuperview];
	[array removeObject:label];
}

#pragma mark TextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
}

- (void)textViewDidEndEditing:(UITextView *)textView {
	if ([textView hasText]) {
		// Create new UILabel
		CGPoint pointForLabel = CGPointMake(textView.frame.origin.x + kTextAndLabelXDifference,
											textView.frame.origin.y + kTextAndLabelYDifference);
		UILabel *label = [self addTextNoteLabelAtPoint:pointForLabel
											  withText:textView.text
												toView:self.scrollView.spaceView];
		[textNotes addObject:label];
		[label release];
		
		UITapGestureRecognizer *doubleTap = [self newDoubleTapGestureForLabel];
		[label addGestureRecognizer:doubleTap];
		[doubleTap release];
		
		// Save new element
		Element *element = [[ElementManager sharedInstance] newEmptyAbstractLabel];
		element.x = [NSNumber numberWithInt:pointForLabel.x];
		element.y = [NSNumber numberWithInt:pointForLabel.y];
		element.text = textView.text;
		[[ElementManager sharedInstance] save];
		[element release];
	}
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
		UILabel *label = (UILabel *)gesture.view;
		[self removeFromSuperviewLabel:label andFromArray:textNotes];

		CGRect textViewRect = CGRectMake(label.frame.origin.x - kTextAndLabelXDifference,
										 label.frame.origin.y - kTextAndLabelYDifference,
										 kTextNoteWidth,
										 kTextNoteHeight);

		[self addTextViewWithRect:textViewRect withText:label.text toView:self.scrollView.spaceView];
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
		CGPoint location = [gesture locationInView:self.scrollView.spaceView];
		CGRect textViewRect = CGRectMake(location.x,
										 location.y,
										 kTextNoteWidth,
										 kTextNoteHeight);
		[self addTextViewWithRect:textViewRect withText:@"" toView:self.scrollView.spaceView];
	}
}

@end
