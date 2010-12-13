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


extern const CGFloat fakeX;
extern const CGFloat fakeY;
extern NSString * const fakeText;
extern const BOOL defaultIsSelectedState;

@interface THCUIComponentsTestUtils : GTMTestCase {

}

+ (id<ElementInterface>)newMockElement;

- (void)assertUIComponent:(id<THCUIComponentWithElementProtocol>)component 
					 hasX:(CGFloat)x 
					 hasY:(CGFloat)y 
				  hasText:(NSString *)text 
			   isSelected:(BOOL)isSelected
				 contains:(id<ElementInterface>)element;

@end
