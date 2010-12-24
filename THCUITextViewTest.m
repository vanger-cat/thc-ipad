//
//  THCTextViewWithElementTest.m
//  thc-ipad
//
//  Created by Vanger on 13.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "GTMSenTestCase.h"
#import "ElementMock.h"
#import "THCUITextView.h"
#import "THCUIComponentsTestUtils.h"

@interface THCUITextViewTest : THCUIComponentsTestUtils {
	ElementMock *mockElement;
	THCUITextView *textView;
	UIView *fakeView;
}
@end

@implementation THCUITextViewTest

- (void)setUp {
	mockElement = [THCUIComponentsTestUtils newMockElement];
	fakeView = [UIView alloc];
	textView = [THCUITextView createInView:fakeView
									withElement:mockElement];
	[mockElement release];
}

- (void)testLabelCreation{
	[self assertUIComponent:textView 
					   hasX:kFakeX 
					   hasY:kFakeY 
					hasText:kFakeText 
				 isSelected:kDefaultIsSelectedState 
				   contains:mockElement];
}

- (void)testTrimmingOfText {
	NSString *testString = @"\n\n\nAAAAA     AAAAAAAA       \n\n\n";
	textView.text = testString;
	STAssertEqualStrings(textView.text, 
						 [testString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],
						 @"text value should be returned without any spaces in in the beginning and ending");
}

- (void)testElementTypeAfterCreation {
	STAssertEqualStrings(textView.element.type, kTypeTextViewForTests, @"type of element isn't set");
}

- (void)testHasTextReturnNoIfFieldEmpty {
	mockElement.text = @"";
	THCUITextView *emptyTextView = [THCUITextView createInView:fakeView
														withElement:mockElement];
	STAssertEquals([emptyTextView hasText], NO, @"just created text view should empty");
}

- (void)tearDown {
	[fakeView release];
	[textView release];
}

@end