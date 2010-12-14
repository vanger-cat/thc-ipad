//
//  UIComponentsUtils.m
//  thc-ipad
//
//  Created by Vanger on 03.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCUIComponentsUtils.h"
#import "THCFonts.h"
#import "THCColors.h"

@implementation THCUIComponentsUtils

+ (void)changeXOriginOfView:(UIView *)superView withNewX:(CGFloat)newX ofSubview:(UIView *)view {
	CGRect frame  = superView.frame;
	frame.origin.x = newX - view.frame.origin.x;
	superView.frame = frame;
}

+ (void)changeYOriginOfView:(UIView *)superView withNewY:(CGFloat)newY ofSubview:(UIView *)view {
	CGRect frame  = superView.frame;
	frame.origin.y =  newY - view.frame.origin.y;
	superView.frame = frame;
}

+ (CGRect)newRectFromOldRect:(CGRect)rect forText:(NSString *)text withMinimalHeight:(CGFloat)minimalHeight andMaximalHeight:(CGFloat)maximalHeight {
	CGRect newRect = rect;
		// the string "\n\n\nA" necessary to have some additional space in TextView
	CGSize newTextSize = [text sizeWithFont:[UIFont fontForTextNote] 
						  constrainedToSize:CGSizeMake(rect.size.width, maximalHeight)];
	newRect.size.height = MAX(minimalHeight, newTextSize.height);
	return newRect;
}

+ (void)resizeTextView:(UITextView *)textView withMinimalHeight:(CGFloat)minimalHeight andMaximalHeight:(CGFloat)maximalHeight {
	textView.frame = [self newRectFromOldRect:textView.frame 
									  forText:[NSString stringWithFormat:@"%@\n\n\nA", textView.text] 
							withMinimalHeight:minimalHeight 
							 andMaximalHeight:maximalHeight];
}

+ (void)resizeLabel:(UILabel *)label withMinimalHeight:(CGFloat)minimalHeight andMaximalHeight:(CGFloat)maximalHeight {
	label.frame = [self newRectFromOldRect:label.frame 
								   forText:label.text 							
						 withMinimalHeight:minimalHeight 
						  andMaximalHeight:maximalHeight];

}


+ (CGRect)frameAroundRect:(CGRect)frame withBorder:(CGFloat)borderWidth {
	return CGRectMake(frame.origin.x - borderWidth, 
					  frame.origin.y - borderWidth, 
					  frame.size.width + 2 * borderWidth, 
					  frame.size.height + 2 * borderWidth);
}

+ (void)setupTextView:(UITextView *)textView andDelegate:(id)delegate {
	textView.contentInset = UIEdgeInsetsZero;
	textView.delegate = delegate;
	textView.backgroundColor = [UIColor colorForEditedTextNoteBackground];
	textView.textColor = [UIColor whiteColor];
	textView.font = [UIFont fontForTextNote];
	textView.editable = YES;
	textView.scrollEnabled = NO;
}

+ (void)setupLabel:(UILabel *)label {
	label.userInteractionEnabled = YES;
	label.numberOfLines = 0;
	label.backgroundColor = [UIColor colorForTextNoteBackground];
	label.textColor = [UIColor whiteColor];
	label.font = [UIFont fontForTextNote];
}

+ (CGFloat) xOriginInSuperViewOfView:(UIView *)view {
	return view.superview.frame.origin.x + view.frame.origin.x;
}

+ (CGFloat) yOriginInSuperViewOfView:(UIView *)view {
	return view.superview.frame.origin.y +  view.frame.origin.y;
}

+ (CGRect)rectInSuperSuperViewOfView:(UIView *)view {
	return CGRectMake([self xOriginInSuperViewOfView:view], 
					  [self yOriginInSuperViewOfView:view], 
					  view.frame.size.width,
					  view.frame.size.height);
}

+ (THCUIComponentAbstract *)getBasicComponentOf:(UIView *)view {
	UIView *currentView = view;
	int i = 0;
	while (i < 10 && ![[currentView class]  isSubclassOfClass:[THCUIComponentAbstract class]]) {
		currentView = currentView.superview;
		i++;
	}
	if (i < 10)
		return (THCUIComponentAbstract *)currentView;
	else {
		return NULL;
	}
}

+ (void)changeSizeOfView:(UIView *)view toSize:(CGSize)size {
	CGRect frame = view.frame;
	frame.size = size;
	view.frame = frame;
}

@end
