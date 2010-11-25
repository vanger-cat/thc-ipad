//
//  THCElementLabel.m
//  thc-ipad
//
//  Created by Vanger on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCLabelWithElement.h"
#import "THCFonts.h"
#import "THCColors.h"

const CGFloat kTextAndLabelXDifference = 8;
const CGFloat kTextAndLabelYDifference = 8;

const CGFloat kTextNoteWidth = 150;
const CGFloat kTextNoteHeight = 100;
const CGFloat kTextNoteHeightMax = 9999;

@implementation THCLabelWithElement

@synthesize element;
@synthesize textViewDelegate;

- (Element *)saveComponentStateToElement {
	element.x = [NSNumber numberWithInt:self.frame.origin.x];
	element.y = [NSNumber numberWithInt:self.frame.origin.y];
	element.text = self.text;
	
	return element;
}

- (void)dealloc {
	[element release];
	[super dealloc];
}

+ (UILabel *)addLabelAtPoint:(CGPoint)point toView:(UIView *)aView withElement:(Element *)newElement withDelegate:(id<UITextViewDelegate>)delegate{
	CGSize size = [newElement.text sizeWithFont:[UIFont fontForTextNote] 
						   constrainedToSize:CGSizeMake(kTextNoteWidth, kTextNoteHeightMax)];
	THCLabelWithElement *label = [[THCLabelWithElement alloc] initWithFrame:CGRectMake(point.x, point.y, kTextNoteWidth, size.height)];
	label.element = newElement;
	
	label.userInteractionEnabled = YES;
	label.numberOfLines = 0;
	label.text = newElement.text;
	label.backgroundColor = [UIColor colorForTextNoteBackground];
	label.textColor = [UIColor whiteColor];
	label.font = [UIFont fontForTextNote];
	label.textViewDelegate = delegate;
	
	UITapGestureRecognizer *doubleTap = [self newDoubleTapGestureForLabel];
	[label addGestureRecognizer:doubleTap];
	[doubleTap release];
	
	[aView addSubview:label];
	
	[label release];
	return label;
}

+ (UITapGestureRecognizer *)newDoubleTapGestureForLabel {
	UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelDoubleTapped:)];
	doubleTap.numberOfTapsRequired = 2;
	return doubleTap;
}

+ (void)labelDoubleTapped:(UITapGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateRecognized) {
		THCLabelWithElement *labelWithElement = (THCLabelWithElement *)gesture.view;

		CGRect textViewRect = CGRectMake(labelWithElement.frame.origin.x - kTextAndLabelXDifference,
										 labelWithElement.frame.origin.y - kTextAndLabelYDifference,
										 kTextNoteWidth,
										 kTextNoteHeight);
		[THCTextViewWithElement addTextViewWithRect:textViewRect 
											 toView:labelWithElement.superview 
										withElement:labelWithElement.element 
									   withDelegate:labelWithElement.textViewDelegate];

		[labelWithElement removeFromSuperview];
	}
}

@end
