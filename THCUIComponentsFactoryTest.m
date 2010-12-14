//
//  THCUIComponentsFactory.m
//  thc-ipad
//
//  Created by Vanger on 14.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "GTMSenTestCase.h"
#import "THCUIComponentAbstract.h"
#import "THCUILabelWithElement.h"
#import "THCUITodoView.h"
#import "THCUITextViewWithElement.h"
#import "THCUIImage.h"
#import "THCUIComponentsFactory.h"
#import "THCUIComponentsTestUtils.h"
#import "ElementInterface.h"

@interface THCUIComponentsFactoryTest : GTMTestCase {
	id<UITextViewDelegate> textViewDelegateMock;
	THCUIComponentsFactory *factory;
	UIView *fakeView;
	id<ElementInterface> mockElement;
}

@end


@implementation THCUIComponentsFactoryTest

- (void)setUp {
	textViewDelegateMock = [OCMockObject niceMockForProtocol:@protocol(UITextViewDelegate)];
	factory = [THCUIComponentsFactory newFactoryWithTextViewDelegate:textViewDelegateMock];
	fakeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
	
	mockElement = [[THCUIComponentsTestUtils newMockElement] retain];
}

- (void)testCreationOfFactory {
	STAssertEqualObjects(textViewDelegateMock, factory.textViewDelegate, @"text view delegate is not set");
}

- (void)testCreationOfLabel {
	id<THCUIComponentWithElementProtocol> component = [factory addComponentOfType:@"label" toView:fakeView withElement:mockElement];
	STAssertEqualStrings([component class],
						 [THCUILabelWithElement class],
						 @"on 'label' should return THCLabelWithElement component");
	
	
}

- (void)testCreationOfTextView {
	id<THCUIComponentWithElementProtocol> component = [factory addComponentOfType:@"textView" toView:fakeView withElement:mockElement];
	STAssertEqualStrings([component class],
						 [THCUITextViewWithElement class],
						 @"on 'todo' should return THCTextViewWithElement component");
}

- (void)testCreationOfTodo {
	id<THCUIComponentWithElementProtocol> component = [factory addComponentOfType:@"todo" toView:fakeView withElement:mockElement];
	STAssertEqualStrings([component class],
						 [THCUITodoView class],
						 @"on 'todo' should return THCUITodoView component");
	
	
}

- (void)testCreationOfImage {
	id<THCUIComponentWithElementProtocol> component = [factory addComponentOfType:@"image" toView:fakeView withElement:mockElement];
	STAssertEqualStrings([component class],
						 [THCUIImage class],
						 @"on 'todo' should return THCUIImage component");
}

- (void)testCreationOfUnknownThrowException {
	STAssertThrows([factory addComponentOfType:@"aaaaaaa!!!" toView:fakeView withElement:mockElement], @"must throw exception, if don't known such type of element");
}

- (void)tearDown {
	[mockElement release];
	[fakeView release];
	[factory release];
	[textViewDelegateMock release];
}
@end
