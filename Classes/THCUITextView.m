//
//  THCTextViewWithElement.m
//  thc-ipad
//
//  Created by Vanger on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCUITextView.h"
#import "THCFonts.h"
#import "THCColors.h"
#import "THCUIComponentsUtils.h"

NSString * const kTypeTextView = @"textview";
const CGFloat kMinimalTextViewHeight = 100;

const CGFloat kTextAndLabelXDifference = 8;
const CGFloat kTextAndLabelYDifference = 8;

@implementation THCUITextView

static id<UITextViewDelegate> defaultTextViewDelegate;

@synthesize textView;
@synthesize typeOfEditedComponent;

+ (void)setDefaultTextViewDelegate:(id<UITextViewDelegate>)newDelegate {
	defaultTextViewDelegate = newDelegate;
}

+ (THCUITextView *)createInView:(UIView *)aView withElement:(id<ElementInterface>)element {
	THCUITextView *textViewWithElement = [[THCUITextView alloc] initWithFrame:CGRectMake([element.x intValue], [element.y intValue], kTextComponentWidth, 0)];

	textViewWithElement.typeOfEditedComponent = element.type;
	textViewWithElement.element = element;
	
	[THCUIComponentsUtils setupTextView:textViewWithElement.textView andDelegate:defaultTextViewDelegate];
	textViewWithElement.text = element.text;

	[aView addSubview:textViewWithElement];
	
	[textViewWithElement.textView becomeFirstResponder];

	[textViewWithElement release];
	
	return textViewWithElement;
}

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
	return [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
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

- (BOOL)hasText {
	return ![self.text isEqualToString:@""];
}

- (NSString *)type {
	return kTypeTextView;
}

- (void)dealloc {
	[textView release];
	[super dealloc];
}

@end
