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
#import "THCUILabel.h"
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
	mockElement.type = kTypeLabelForTests;
	[factory registerNewUIComponent:[THCUILabel class] withType:kTypeLabelForTests];
	id<THCUIComponentWithElementProtocol> component = [factory addComponentToView:fakeView withElement:mockElement];
	STAssertTrue([component isMemberOfClass:[THCUILabel class]], @"should return THCLabelWithElement component");
}

- (void)testCreationOfUnknownThrowException {
	mockElement.type = @"aaaaaaa!!!";
	STAssertThrows([factory addComponentToView:fakeView withElement:mockElement], @"must throw exception, if don't known such type of element");
}

- (void)tearDown {
	[mockElement release];
	[fakeView release];
	[factory release];
	[textViewDelegateMock release];
}
@end
