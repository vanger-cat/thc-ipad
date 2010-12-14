//
//  THCTextViewWithElement.h
//  thc-ipad
//
//  Created by Vanger on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ElementInterface.h"
#import "THCUIComponentAbstract.h"

extern NSString * const kTypeTextView;
extern const CGFloat kMinimalTextViewHeight;
extern const CGFloat kTextAndLabelXDifference;
extern const CGFloat kTextAndLabelYDifference;

@interface THCUITextViewWithElement : THCUIComponentAbstract {
	UITextView *textView;
}

@property (nonatomic,retain) UITextView *textView;

+ (THCUITextViewWithElement *)addTextViewToView:(UIView *)aView withElement:(id<ElementInterface>)element withDelegate:(id<UITextViewDelegate>)delegate;

- (void)completeEditing;

@end
