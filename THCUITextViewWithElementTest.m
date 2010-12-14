//
//  THCTextViewWithElementTest.m
//  thc-ipad
//
//  Created by Vanger on 13.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "GTMSenTestCase.h"
#import "ElementMock.h"
#import "THCUITextViewWithElement.h"
#import "THCUIComponentsTestUtils.h"

@interface THCUITextViewWithElementTest : THCUIComponentsTestUtils {
	ElementMock *mockElement;
	THCUITextViewWithElement *textView;
}
@end

@implementation THCUITextViewWithElementTest

- (void)setUp {
	mockElement = [THCUIComponentsTestUtils newMockElement];
	UIView *view = [UIView alloc];
	textView = [THCUITextViewWithElement addTextViewToView:view
											 withElement:mockElement 
											withDelegate:NULL];
	[view release];
	[mockElement release];
}

- (void)testLabelCreation{
	[self assertUIComponent:textView 
					   hasX:kFakeX 
					   hasY:kFakeY 
					hasText:kFakeText 
				 isSelected:defaultIsSelectedState 
				   contains:mockElement];
}

- (void)tearDown {
	[textView release];
}

@end