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
	UISwitch *checkbox;
	UILabel *label;
	UIView *bottomLayer;
}

@property (nonatomic, retain) UISwitch *checkbox;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIView *bottomLayer;
@property (nonatomic) BOOL isChecked;

+ (THCUITodo *)createInView:(UIView *)aView withElement:(Element *)newElement;
+ (UIGestureRecognizer *)newGestureForConvertingToLabel;

@end
