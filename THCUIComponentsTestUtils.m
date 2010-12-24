//
//  THCUIComponentsTestUtils.m
//  thc-ipad
//
//  Created by Vanger on 13.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCUIComponentsTestUtils.h"
#import "ElementMock.h"

const CGFloat kFakeX = 50;
const CGFloat kFakeY = 50;
NSString * const kFakeText = @"test string!";
NSString * const kFakeType = @"fake type!";
const BOOL kDefaultIsSelectedState = NO;
NSString * const kTypeTextViewForTests = @"textview";
NSString * const kTypeLabelForTests = @"label";
NSString * const kTypeTodoForTests = @"todo";
NSString * const kTypeImageForTests = @"image";
NSString * const kTypeLinkForTests = @"link";


@implementation THCUIComponentsTestUtils

+ (id<ElementInterface>)newMockElement {
	ElementMock *mockElement = [ElementMock alloc];
	mockElement.x = [NSNumber numberWithInt:kFakeX];
	mockElement.y = [NSNumber numberWithInt:kFakeY];
	mockElement.text = kFakeText;
	mockElement.type = kFakeType;
	
	return mockElement;
}

+ (UIView *)newEmptyView {
	return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
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
