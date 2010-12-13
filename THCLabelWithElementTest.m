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
	mockElement = [THCUIComponentsTestUtils createMockElement];
	label = [THCLabelWithElement addLabelToView:[UIView alloc] 
									withElement:mockElement
								   withDelegate:NULL];
}

- (void)testLabelCreation{
	[self assertUIComponent:label 
					   hasX:fakeX 
					   hasY:fakeY 
					hasText:fakeText 
				 isSelected:defaultIsSelectedState 
				   contains:mockElement];
}

@end
