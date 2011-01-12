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

- (THCUIComponentAbstractFake *)newComponentCloseToTheLeft {
	CGFloat width = 100;
	return [THCUIComponentAbstractFake newComponentWithX:testedComponent.x - width
													andY:testedComponent.y
												andWidth:width 
											   andHeight:100];
}

- (void)testThatConnectingWithNoComponentsSetsAllConnectionsToNil {
	testedComponent.topElement = testedComponent;
	testedComponent.leftElement = testedComponent;
	testedComponent.rightElement = testedComponent;
	testedComponent.bottomElement = testedComponent;
	
	[testedComponent connectIfPossibleWithComponents:components withCellSize:kSizeOfCellForTest];
	
	[self assertThatAllConnectionsIsNil:testedComponent];
}

- (void)testThatConnectingOfElementsWillNotConnectElementToHimself {
	[components addObject:testedComponent];
	[testedComponent connectIfPossibleWithComponents:components withCellSize:kSizeOfCellForTest];
	[self assertThatAllConnectionsIsNil:testedComponent];
}

- (void)testThatConnectingWithFarElementCauseNothing {
	THCUIComponentAbstractFake *secondFake = [self newFarAwayComponent];
	
	[components addObject:secondFake];
	[testedComponent connectIfPossibleWithComponents:components withCellSize:kSizeOfCellForTest];
	[secondFake release];
	[self assertThatAllConnectionsIsNil:testedComponent];
}

- (void)testConnectingWithLeftSetsLeftElementOfTestedElement {
	THCUIComponentAbstractFake *secondFake = [self newComponentCloseToTheLeft];
	
	[components addObject:secondFake];
	[testedComponent connectIfPossibleWithComponents:components withCellSize:kSizeOfCellForTest];
	[secondFake release];
	STAssertEquals(testedComponent.leftElement, secondFake, @"left component of tested component should be attached");
}

- (void)testConnectingWithLeftSetsRightElementOfLeftComponent {
	THCUIComponentAbstractFake *secondFake = [self newComponentCloseToTheLeft];
	
	[components addObject:secondFake];
	[testedComponent connectIfPossibleWithComponents:components withCellSize:kSizeOfCellForTest];
	[secondFake release];
	STAssertEquals(secondFake.rightElement, testedComponent, @"right component should of left component should be attached");
}

- (void)testSome {
	
}

- (void)tearDown {
	[testedComponent release];
	[components release];
}

@end
