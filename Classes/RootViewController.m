    //
//  RootViewController.m
//  thc-ipad
//
//  Created by Dmitry Volkov on 12.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "THCColors.h"
#import "THCFonts.h"

@implementation RootViewController

@synthesize textNotes;
@synthesize scrollView;

const CGFloat kTextNoteWidth = 150;
const CGFloat kTextNoteHeight = 100;
const CGFloat kTextNoteHeightMax = 9999;

- (UITextView *)addTextViewWithRect:(CGRect)rect withText:(NSString *)text toView:(UIView *)aView {
	UITextView *textView = [[UITextView alloc] init];
	textView.contentInset = UIEdgeInsetsZero;
	textView.text = text;
	textView.delegate = self;
	textView.backgroundColor = [UIColor colorForEditedTextNoteBackground];
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
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(point.x, point.y, size.width, size.height)];
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

- (void)viewDidLoad {
    [super viewDidLoad];
	
	textNotes = [[NSMutableArray alloc] init];
	
	UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGesturePerformed:)];
	doubleTap.numberOfTapsRequired = 2;
	[self.scrollView addGestureRecognizer:doubleTap];
	[doubleTap release];
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

#pragma mark TextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
}

- (void)textViewDidEndEditing:(UITextView *)textView {
	// Create new UILabel
	UILabel *label = [self addTextNoteLabelAtPoint:CGPointMake(textView.frame.origin.x, textView.frame.origin.y)
										  withText:textView.text
											toView:self.scrollView];
	UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelDoubleTapped:)];
	doubleTap.numberOfTapsRequired = 2;
	[label addGestureRecognizer:doubleTap];
	[doubleTap release];
		
	[textView removeFromSuperview];
}

#pragma mark Gestures

- (void)labelDoubleTapped:(UITapGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateRecognized) {
		UILabel *label = (UILabel *)gesture.view;
		[label removeFromSuperview];
		
		CGRect textViewRect = CGRectMake(label.frame.origin.x - 10,
										 label.frame.origin.y - 10,
										 label.frame.size.width + 10,
										 label.frame.size.height + 60);
		
		[self addTextViewWithRect:textViewRect withText:label.text toView:self.scrollView];
	}
}

- (void)doubleTapGesturePerformed:(UITapGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateRecognized) {
		CGPoint location = [gesture locationInView:self.view];
		CGRect textViewRect = CGRectMake(location.x, location.y, kTextNoteWidth, kTextNoteHeight);
		[self addTextViewWithRect:textViewRect withText:@"" toView:self.scrollView];
	}
}

@end
