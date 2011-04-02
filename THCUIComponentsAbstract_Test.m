//
//  THCUIComponentsAbstractTest.m
//  thc-ipad
//
//  Created by Vanger on 02.01.11.
//  Copyright 2011 Magic Ink. All rights reserved.
//

#import "GTMSenTestCase.h"
#import "THCUIComponentAbstractFake.h"

const CGFloat kSizeOfCellForTest = 20;

@interface THCUIComponentsAbstract_Test : GTMTestCase {
	NSMutableArray *components;
	THCUIComponentAbstractFake *testedComponent;
}

@end


@implementation THCUIComponentsAbstract_Test

- (void)setUp {
	components = [[NSMutableArray array] retain];
	testedComponent = [THCUIComponentAbstractFake newComponentWithX:0 
															   andY:0 
														   andWidth:kSizeOfCellForTest * 4 
														  andHeight:kSizeOfCellForTest];
}

- (void)assertThatAllConnectionsIsNil:(THCUIComponentAbstractFake *)component {
	STAssertNil(testedComponent.topElement, @"top element should be NULL");
	STAssertNil(testedComponent.leftElement, @"left element should be NULL");
	STAssertNil(testedComponent.rightElement, @"right element should be NULL");
	STAssertNil(testedComponent.bottomElement, @"bottom element should be NULL");
}

- (THCUIComponentAbstractFake *)newFarAwayComponent {
	return [THCUIComponentAbstractFake newComponentWithX:10000
													andY:10000
												andWidth:100 
											   andHeight:100];
}

- (THCUIComponentAbstractFake *)newComponentCloseToLeft {
	CGFloat width = 100;
	return [THCUIComponentAbstractFake newComponentWithX:testedComponent.x - width
													andY:testedComponent.y
												andWidth:width 
											   andHeight:100];
}

- (THCUIComponentAbstractFake *)newComponentCloseToRight {
	CGFloat width = 100;
    
    NSLog(@"testedComponent.width = %f", testedComponent.width);
	return [THCUIComponentAbstractFake newComponentWithX:testedComponent.x + testedComponent.width
													andY:testedComponent.y
												andWidth:width 
											   andHeight:100];
}

- (void)makeAllConnectionsBusyFor:(THCUIComponentAbstract *)component {
    component.topElement = testedComponent;
	component.leftElement = testedComponent;
	component.rightElement = testedComponent;
	component.bottomElement = testedComponent;
}

- (void)testThatConnectingWithNoComponentsSetsAllConnectionsToNil {
	[self makeAllConnectionsBusyFor:testedComponent];
	
	[testedComponent connectIfPossibleWithComponents:components withCellSize:kSizeOfCellForTest];
	
	[self assertThatAllConnectionsIsNil:testedComponent];
}

- (void)testThatConnectingOfElementsWillNotConnectElementToHimself {
	[components addObject:testedComponent];
	[testedComponent connectIfPossibleWithComponents:components withCellSize:kSizeOfCellForTest];
	[self assertThatAllConnectionsIsNil:testedComponent];
}

- (void)testShouldNotConnectWithFarElement {
	THCUIComponentAbstractFake *farAwayComponent = [self newFarAwayComponent];
    
    [components addObject:farAwayComponent];
	[testedComponent connectIfPossibleWithComponents:components withCellSize:kSizeOfCellForTest];
//	[farAwayComponent release];
	[self assertThatAllConnectionsIsNil:testedComponent];
}

//- (void)testConnectFromLeftSide {
//	THCUIComponentAbstractFake *elementToAttach = [self newComponentCloseToTheLeft];
//	
//	[components addObject:elementToAttach];
//	[testedComponent connectIfPossibleWithComponents:components withCellSize:kSizeOfCellForTest];
//	[elementToAttach release];
//	STAssertEquals(testedComponent.leftElement, elementToAttach, @"left component of tested component should be attached");
//}
//
- (void)testConnectFromRightSide {
    NSLog(@"%@", [testedComponent description]);
	   
	THCUIComponentAbstractFake *componentToAttach = [self newComponentCloseToRight];
	
	[components addObject:componentToAttach];
	[testedComponent connectIfPossibleWithComponents:components withCellSize:kSizeOfCellForTest];
	[componentToAttach release];
	STAssertEquals(testedComponent.rightElement, componentToAttach, @"right component should of left component should be attached");
}

- (void)tearDown {
	[testedComponent release];
	[components release];
}

@end
