//
//  THCTextViewWithElement.m
//  thc-ipad
//
//  Created by Vanger on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCTextViewWithElement.h"
#import "THCFonts.h"
#import "THCColors.h"

@implementation THCTextViewWithElement

@synthesize element;

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

+ (UITextView *)addTextViewWithRect:(CGRect)rect withText:(NSString *)text toView:(UIView *)aView withElement:(Element *)element withDelegate:(id<UITextViewDelegate>)delegate{
	THCTextViewWithElement *textView = [[THCTextViewWithElement alloc] init];
	textView.element = element;
	
	textView.contentInset = UIEdgeInsetsZero;
	textView.text = text;
	textView.delegate = delegate;
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

@end
