//
//  UIComponentsUtils.h
//  thc-ipad
//
//  Created by Vanger on 03.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THCUIComponentAbstract.h"

@interface THCUIComponentsUtils : NSObject {

}

+ (CGRect)frameAroundRect:(CGRect)frame withBorder:(CGFloat)borderWidth;

+ (CGRect)newRectFromOldRect:(CGRect)rect forText:(NSString *)text withMinimalHeight:(CGFloat)minimalHeight andMaximalHeight:(CGFloat)maximalHeight;
+ (void)resizeTextView:(UITextView *)textView withMinimalHeight:(CGFloat)minimalHeight andMaximalHeight:(CGFloat)maximalHeight;
+ (void)resizeLabel:(UILabel *)label withMinimalHeight:(CGFloat)minimalHeight andMaximalHeight:(CGFloat)maximalHeight;

+ (void)changeXOriginOfView:(UIView *)superView withNewX:(CGFloat)newX ofSubview:(UIView *)view;
+ (void)changeYOriginOfView:(UIView *)superView withNewY:(CGFloat)newY ofSubview:(UIView *)view;

+ (void)setupTextView:(UITextView *)textView andDelegate:(id)delegate;
+ (void)setupLabel:(UILabel *)label;

+ (CGFloat) xOriginInSuperViewOfView:(UIView *)view;
+ (CGFloat) yOriginInSuperViewOfView:(UIView *)view;
+ (CGRect)rectInSuperSuperViewOfView:(UIView *)view;

+ (THCUIComponentAbstract *)getBasicComponentOf:(UIView *)view;

+ (void)changeSizeOfView:(UIView *)view toSize:(CGSize)size;

@end
