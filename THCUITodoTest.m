//
//  THCUITodoTest.m
//  thc-ipad
//
//  Created by Vanger on 14.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "GTMSenTestCase.h"
#import "THCUIComponentsTestUtils.h"
#import "THCUITodo.h"

@interface THCUITodoTest : THCUIComponentsTestUtils {
	
}

@end

@implementation THCUITodoTest

- (void)testElementTypeAfterCreation {
	UIView *fakeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
	id<ElementInterface> mockElement = [THCUIComponentsTestUtils newMockElement]; 
	
	THCUITodo *image = [THCUITodo addTodoToView:fakeView withElement:mockElement withDelegate:NULL];
	STAssertEqualStrings(image.element.type, kTypeTodoForTests, @"type of element isn't set");
	
	[mockElement release];
	[fakeView release];
}



@end
