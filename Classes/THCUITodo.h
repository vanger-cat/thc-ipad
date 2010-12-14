//
//  THCTodoView.h
//  thc-ipad
//
//  Created by Vanger on 24.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "THCUIComponentAbstract.h"
#import "Element.h"

extern NSString * const kTypeTodo;

@interface THCUITodo : THCUIComponentAbstract {
	id<UITextViewDelegate> textViewDelegate;
	UISwitch *checkbox;
	UILabel *label;
	UIView *bottomLayer;
}

@property (nonatomic, retain) id<UITextViewDelegate> textViewDelegate;
@property (nonatomic, retain) UISwitch *checkbox;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIView *bottomLayer;

+ (THCUITodo *)addTodoToView:(UIView *)aView withElement:(Element *)newElement withDelegate:(id<UITextViewDelegate>)delegate;
+ (UIGestureRecognizer *)newGestureForConvertingToLabel;

@end
