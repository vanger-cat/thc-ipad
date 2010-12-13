//
//  THCElementLabel.h
//  thc-ipad
//
//  Created by Vanger on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Element.h"
#import "THCUIComponentWithElementDelegate.h"
#import "THCTextViewWithElement.h"
#import "THCUIComponentAbstract.h"

extern const CGFloat kMinimalLabelHeight;

@interface THCLabelWithElement : THCUIComponentAbstract {
	id<UITextViewDelegate> textViewDelegate;
	UILabel *label;
}

@property (nonatomic, retain) id<UITextViewDelegate> textViewDelegate;
@property (nonatomic, retain) UILabel *label;

+ (THCLabelWithElement *)addLabelToView:(UIView *)aView withElement:(id<ElementInterface>)newElement withDelegate:(id<UITextViewDelegate>)delegate;

+ (UITapGestureRecognizer *)newGestureForConvertingToTextEdit;
+ (UITapGestureRecognizer *)newGestureForConvertingToTODO;

@end
