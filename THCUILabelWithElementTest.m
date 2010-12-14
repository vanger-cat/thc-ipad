//
//  THCLabelWithElementTest
//  thc-ipad
//
//  Created by Vanger on 13.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "GTMSenTestCase.h"
#import "THCUILabelWithElement.h"
#import "ElementMock.h"
#import "THCUIComponentsTestUtils.h"

@interface THCUILabelWithElementTest : THCUIComponentsTestUtils {
	ElementMock *mockElement;
	THCUILabelWithElement *label;
}
@end

@implementation THCUILabelWithElementTest

- (void)setUp {
	mockElement = [THCUIComponentsTestUtils newMockElement];
	UIView *view = [UIView alloc];
	label = [THCUILabelWithElement addLabelToView:view
									withElement:mockElement
								   withDelegate:NULL];
	[view release];
	[mockElement release];
}

- (void)testLabelCreation{
	[self assertUIComponent:label 
					   hasX:kFakeX 
					   hasY:kFakeY 
					hasText:kFakeText 
				 isSelected:defaultIsSelectedState 
				   contains:mockElement];
}

- (void)testElementTypeAfterCreation {
	STAssertEqualStrings(label.element.type, @"label", @"type of element should be set to 'label'");
}

- (void)tearDown {
	[label release];
}

@end
