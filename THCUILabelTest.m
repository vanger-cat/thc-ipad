//
//  THCLabelWithElementTest
//  thc-ipad
//
//  Created by Vanger on 13.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "GTMSenTestCase.h"
#import "THCUILabel.h"
#import "ElementMock.h"
#import "THCUIComponentsTestUtils.h"

@interface THCUILabelTest : THCUIComponentsTestUtils {
	ElementMock *mockElement;
	THCUILabel *label;
}
@end

@implementation THCUILabelTest

- (void)setUp {
	mockElement = [THCUIComponentsTestUtils newMockElement];
	UIView *view = [UIView alloc];
	label = [THCUILabel createInView:view
									withElement:mockElement];
	[view release];
	[mockElement release];
}

- (void)testLabelCreation{
	[self assertUIComponent:label 
					   hasX:kFakeX 
					   hasY:kFakeY 
					hasText:kFakeText 
				 isSelected:kDefaultIsSelectedState 
				   contains:mockElement];
}

- (void)testElementTypeAfterCreation {
	STAssertEqualStrings(label.element.type, kTypeLabelForTests, @"type of element isn't set");
}

- (void)tearDown {
	[label release];
}

@end
