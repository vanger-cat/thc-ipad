//
//  THCUIComponentsTestUtils.m
//  thc-ipad
//
//  Created by Vanger on 13.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCUIComponentsTestUtils.h"
#import "ElementMock.h"

const CGFloat fakeX = 50;
const CGFloat fakeY = 50;
NSString * const fakeText = @"test string!";
const BOOL defaultIsSelectedState = NO;

@implementation THCUIComponentsTestUtils

+ (id<ElementInterface>)newMockElement {
	ElementMock *mockElement = [ElementMock alloc];
	mockElement.x = [NSNumber numberWithInt:fakeX];
	mockElement.y = [NSNumber numberWithInt:fakeY];
	mockElement.text = fakeText;
	
	return mockElement;
}

- (void)assertUIComponent:(id<THCUIComponentWithElementProtocol>)component 
					 hasX:(CGFloat)x 
					 hasY:(CGFloat)y 
				  hasText:(NSString *)text 
			   isSelected:(BOOL)isSelected
				 contains:(id<ElementInterface>)element {
	STAssertEquals(component.x, x, @"X coordinate setted incorrectly");
	STAssertEquals(component.y, y, @"Y coordinate setted incorrectly");
	
	STAssertEqualObjects(component.text, text, @"Text setted incorrectly");
	
	STAssertEquals(component.selected, isSelected, @"Selected property setted incorrectly");

	STAssertEqualObjects(component.element, element, @"element setted incorrectly");
}


@end
