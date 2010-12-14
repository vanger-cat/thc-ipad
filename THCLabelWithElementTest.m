//
//  THCLabelWithElementTest
//  thc-ipad
//
//  Created by Vanger on 13.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "GTMSenTestCase.h"
#import "THCLabelWithElement.h"
#import "ElementMock.h"
#import "THCUIComponentsTestUtils.h"

@interface THCLabelWithElementTest : THCUIComponentsTestUtils {
	ElementMock *mockElement;
	THCLabelWithElement *label;
}
@end

@implementation THCLabelWithElementTest

- (void)setUp {
	mockElement = [THCUIComponentsTestUtils newMockElement];
	UIView *view = [UIView alloc];
	label = [THCLabelWithElement addLabelToView:view
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

- (void)tearDown {
	[label release];
}

@end
