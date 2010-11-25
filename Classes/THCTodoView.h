//
//  THCTodoView.h
//  thc-ipad
//
//  Created by Vanger on 24.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "THCUIComponentWithElementDelegate.h"
#import "Element.h"

@interface THCTodoView : UIView	<THCUIComponentWithElementDelegate> {
	UISwitch *checkbox;
	UILabel *label;
	Element *element;
}

@property (nonatomic, retain) UISwitch *checkbox;
@property (nonatomic, retain) UILabel *label;

+ (UILabel *)addTodo:(CGPoint)point toView:(UIView *)aView withElement:(Element *)newElement withDelegate:(id<UITextViewDelegate>)delegate;

@end
