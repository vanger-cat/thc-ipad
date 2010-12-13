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

const CGFloat fakeX = 50;
const CGFloat fakeY = 50;
NSString * const fakeText = @"test string!";

@interface THCLabelWithElementTest : GTMTestCase {
	ElementMock *mockElement;
	THCLabelWithElement *label;
}
@end

@implementation THCLabelWithElementTest

- (void)setUp {
	mockElement = [ElementMock alloc];
	mockElement.x = [NSNumber numberWithInt:fakeX];
	mockElement.y = [NSNumber numberWithInt:fakeY];
	label = [THCLabelWithElement addLabelToView:[UIView alloc] 
									withElement:mockElement
								   withDelegate:NULL];
}

- (void)testLabelCreation{
	NSLog(@"%d : %d", (int) label.x, (int) fakeX);
	STAssertEqualObjects(label.element, mockElement, @"element setted incorrectly");
	STAssertEquals(label.x, fakeX, @"X coordinate setted incorrectly");
	STAssertEquals(label.y, fakeY, @"Y coordinate setted incorrectly");
}

@end
