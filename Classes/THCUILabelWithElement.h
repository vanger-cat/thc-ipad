//
//  THCElementLabel.h
//  thc-ipad
//
//  Created by Vanger on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ElementInterface.h"
#import "THCUIComponentWithElementProtocol.h"
#import "THCUITextViewWithElement.h"
#import "THCUIComponentAbstract.h"


extern NSString * const kLabelElementTypeName;
extern const CGFloat kMinimalLabelHeight;

@interface THCUILabelWithElement : THCUIComponentAbstract {
	id<UITextViewDelegate> textViewDelegate;
	UILabel *label;
}

@property (nonatomic, retain) id<UITextViewDelegate> textViewDelegate;
@property (nonatomic, retain) UILabel *label;

+ (THCUILabelWithElement *)addLabelToView:(UIView *)aView withElement:(id<ElementInterface>)newElement withDelegate:(id<UITextViewDelegate>)delegate;

+ (UITapGestureRecognizer *)newGestureForConvertingToTextEdit;
+ (UITapGestureRecognizer *)newGestureForConvertingToTODO;

@end
