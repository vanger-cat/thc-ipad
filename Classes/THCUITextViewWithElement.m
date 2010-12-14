//
//  THCTextViewWithElement.m
//  thc-ipad
//
//  Created by Vanger on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCUITextViewWithElement.h"
#import "THCFonts.h"
#import "THCColors.h"
#import "THCUIComponentsUtils.h"

NSString * const kTypeTextView = @"textview";
const CGFloat kMinimalTextViewHeight = 100;

const CGFloat kTextAndLabelXDifference = 8;
const CGFloat kTextAndLabelYDifference = 8;

@implementation THCUITextViewWithElement

@synthesize textView;

- (id)initWithFrame:(CGRect)frame {
	CGRect viewFrame = [THCUIComponentsUtils frameAroundRect:frame withBorder:kBorderWidth];
	
	[super initWithFrame:viewFrame];
	
	CGRect textViewFrame = CGRectMake(kBorderWidth, 
									  kBorderWidth, 
									  frame.size.width,
									  frame.size.height);
	self.textView = [[UITextView alloc] initWithFrame:textViewFrame];
	[self addSubview:self.textView];
	
	return self;
}

+ (THCUITextViewWithElement *)addTextViewToView:(UIView *)aView withElement:(id<ElementInterface>)element withDelegate:(id<UITextViewDelegate>)delegate {
	THCUITextViewWithElement *textViewWithElement = [[THCUITextViewWithElement alloc] initWithFrame:CGRectMake([element.x intValue], [element.y intValue], kTextComponentWidth, 0)];
	element.type = kTypeTextView;
	textViewWithElement.element = element;
	
	[THCUIComponentsUtils setupTextView:textViewWithElement.textView andDelegate:delegate];
	textViewWithElement.text = element.text;

	[aView addSubview:textViewWithElement];
	
	[textViewWithElement.textView becomeFirstResponder];

	[textViewWithElement release];
	
	return textViewWithElement;
}

- (void)completeEditing {
	[self.textView resignFirstResponder];
}

- (CGFloat)x {
	return [THCUIComponentsUtils xOriginInSuperViewOfView:self.textView] + kTextAndLabelXDifference;
}

- (void)setX:(CGFloat)newX {
	[THCUIComponentsUtils changeXOriginOfView:self withNewX:newX - kTextAndLabelXDifference ofSubview:self.textView];
}

- (CGFloat)y {
	return [THCUIComponentsUtils yOriginInSuperViewOfView:self.textView] + kTextAndLabelYDifference;
}

- (void)setY:(CGFloat)newY {
	[THCUIComponentsUtils changeYOriginOfView:self withNewY:newY - kTextAndLabelYDifference ofSubview:self.textView];
}

- (NSString *)text {
	return self.textView.text;
}	

- (void)setText:(NSString *)newText {
	if (![self.textView.text isEqualToString:newText]) {
		self.textView.text = [newText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	}
	
	
	[THCUIComponentsUtils resizeTextView:self.textView 
					   withMinimalHeight:kMinimalTextViewHeight 
						andMaximalHeight:kTextComponentHeightMax];
	
	self.frame = [THCUIComponentsUtils frameAroundRect:[THCUIComponentsUtils rectInSuperSuperViewOfView:self.textView] 
											withBorder:kBorderWidth]; 
}

- (void)dealloc {
	[textView release];
	[super dealloc];
}

@end
