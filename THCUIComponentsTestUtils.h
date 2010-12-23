//
//  THCUIComponentsTestUtils.h
//  thc-ipad
//
//  Created by Vanger on 13.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMSenTestCase.h"
#import "THCUIComponentWithElementProtocol.h"


extern const CGFloat kFakeX;
extern const CGFloat kFakeY;
extern NSString * const kFakeText;
extern const BOOL kDefaultIsSelectedState;
extern NSString * const kTypeTextViewForTests;
extern NSString * const kTypeLabelForTests;
extern NSString * const kTypeLinkForTests;
extern NSString * const kTypeTodoForTests;
extern NSString * const kTypeImageForTests;

@interface THCUIComponentsTestUtils : GTMTestCase {
}

+ (id<ElementInterface>)newMockElement;

+ (UIView *)newEmptyView;

- (void)assertUIComponent:(id<THCUIComponentWithElementProtocol>)component 
					 hasX:(CGFloat)x 
					 hasY:(CGFloat)y 
				  hasText:(NSString *)text 
			   isSelected:(BOOL)isSelected
				 contains:(id<ElementInterface>)element;

@end
