//
//  THCAppDelegateTest.m
//  thc-ipad
//
//  Created by Vanger on 24.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "GTMSenTestCase.h"
#import "ThcAppDelegate.h"
#import "THCUITextView.h"
#import "THCUIComponentsTestUtils.h"
#import "ElementInterface.h"
#import "THCUIComponentsFactory.h"

@interface ThcAppDelegateTest : GTMTestCase
{
	ThcAppDelegate *appDelegate;
}

@end


@implementation ThcAppDelegateTest

- (void)setUp {
	appDelegate = (ThcAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)testInitializationOfComponentsFactoryIsProper {
//	THCUIComponentsFactory *factory = [appDelegate initComponentsFactory]
	STAssertTrue(NO, @"Continue implementation of this test");
}

- (void)testInitializationOfTextViewIsProper {
	id<ElementInterface> elementMock = [THCUIComponentsTestUtils newMockElement];
	UIView *fakeView = [THCUIComponentsTestUtils newEmptyView];
	
	[appDelegate injectDependencies];
	THCUITextView *textView = [THCUITextView createInView:fakeView withElement:elementMock];
	STAssertNotNULL(textView.textView.delegate, @"UITextViewDelegate instance should be injected to THCUITextView");
}

@end
