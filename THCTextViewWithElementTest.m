//
//  THCTextViewWithElementTest.m
//  thc-ipad
//
//  Created by Vanger on 13.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "GTMSenTestCase.h"
#import "ElementMock.h"
#import "THCTextViewWithElement.h"
#import "THCUIComponentsTestUtils.h"

@interface THCTextViewWithElementTest : THCUIComponentsTestUtils {
	ElementMock *mockElement;
	THCTextViewWithElement *textView;
}
@end

@implementation THCTextViewWithElementTest

- (void)setUp {
	mockElement = [THCUIComponentsTestUtils createMockElement];
	textView = [THCTextViewWithElement addTextViewToView:[UIView alloc] 
											 withElement:mockElement 
											withDelegate:NULL];
}

- (void)testLabelCreation{
	[self assertUIComponent:textView 
					   hasX:fakeX 
					   hasY:fakeY 
					hasText:fakeText 
				 isSelected:defaultIsSelectedState 
				   contains:mockElement];
}

@end