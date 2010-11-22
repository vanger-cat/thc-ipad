//
//  THCTextViewWithElement.h
//  thc-ipad
//
//  Created by Vanger on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Element.h"
#import "THCUIComponentWithElementDelegate.h"
#import "THCLabelWithElement.h"


@interface THCTextViewWithElement : UITextView <THCUIComponentWithElementDelegate> {
	Element *element;
}

+ (UITextView *)addTextViewWithRect:(CGRect)rect withText:(NSString *)text toView:(UIView *)aView withElement:(Element *)element withDelegate:(id<UITextViewDelegate>)delegate;
+ (void)resizeTextView:(UITextView *)textView;
@end
