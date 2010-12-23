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
	UIView *fakeView;
	id<ElementInterface> mockElement;
	THCUITodo *todo;
}

@end

@implementation THCUITodoTest

- (void)setUp {
	fakeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
	mockElement = [THCUIComponentsTestUtils newMockElement]; 
}

- (void)testElementTypeAfterCreation {
	todo = [THCUITodo createInView:fakeView withElement:mockElement withDelegate:NULL];
	STAssertEqualStrings(todo.element.type, kTypeTodoForTests, @"type of element isn't set");
}

- (void)setIsCheckedOfElement:(id<ElementInterface>)element checked:(BOOL)checked {
	element.isChecked = [NSNumber numberWithInt:(int)checked];
}

- (void)testSettingOfCheckedStateForUnchecked {
	[self setIsCheckedOfElement:mockElement checked:NO];
	todo = [THCUITodo createInView:fakeView withElement:mockElement withDelegate:NULL];
	STAssertEquals(todo.isChecked, NO, @"checked state NO of todo is not set");
}

- (void)testSettingOfCheckedStateForChecked {
	[self setIsCheckedOfElement:mockElement checked:YES];
	todo = [THCUITodo createInView:fakeView withElement:mockElement withDelegate:NULL];
	STAssertEquals(todo.isChecked, YES, @"checked state YES of todo is not set");
}

- (void)testIfCheckedStateSavedToElement {
	[self setIsCheckedOfElement:mockElement checked:NO];
	todo = [THCUITodo createInView:fakeView withElement:mockElement withDelegate:NULL];
	todo.isChecked = YES;
	[todo saveComponentStateToElement];
	STAssertEquals([mockElement.isChecked intValue], 1, @"checked state of todo is not saved properly");
}

- (void)tearDown {
	[todo release];
	[mockElement release];
	[fakeView release];
}

@end
