//
//  RootViewControllerTest.m
//  thc-ipad
//
//  Created by Vanger on 13.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "GTMSenTestCase.h"
#import "ElementManager.h"
#import "ElementMock.h"
#import "RootViewController.h"
#import "THCUITextView.h"
#import "THCUILabel.h"
#import "THCUIImage.h"
#import "THCUITodo.h"
#import "THCUILink.h"
#import "THCUIComponentsTestUtils.h"
#import "THCScrollView.h"

@interface RootViewControllerTest : THCUIComponentsTestUtils
{
	RootViewController *rootViewController;
	CGPoint fakePoint;
	UIView *fakeView;
	id<ElementInterface> fakeElement;
}

@end

@implementation RootViewControllerTest

- (void)setUp {
	rootViewController = [[RootViewController alloc] initWithNibName:@"RootViewController" 
															  bundle:nil];
	fakePoint = CGPointMake(kFakeX, kFakeY);
	fakeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
	fakeElement = [ElementMock alloc];
}

- (void)testCreationOfSingleTextViewForNewElement {
	[rootViewController createTextViewAtPoint:fakePoint atView:fakeView withElement:fakeElement];
	
	NSUInteger expectedCount = 1;
	STAssertEquals([fakeView.subviews count], expectedCount, @"New subview is not added to UIView");
}


- (void)testCreationOfTextViewForNewElement {
	[rootViewController createTextViewAtPoint:fakePoint atView:fakeView withElement:fakeElement];

	THCUITextView *textViewWithElement = (THCUITextView *) [fakeView.subviews objectAtIndex:0];
	
	[self assertUIComponent:textViewWithElement 
					   hasX:[THCScrollView getCellCoordinateFromCoordinate:kFakeX]
					   hasY:[THCScrollView getCellCoordinateFromCoordinate:kFakeY] 
					hasText:@"" 
				 isSelected:NO 
				   contains:fakeElement];
}

- (void)addElementWithType:(NSString *)type toArray:(NSMutableArray *)array {
	id<ElementInterface> mockElement;
	mockElement = [THCUIComponentsTestUtils newMockElement];
	mockElement.type = type;
	[array addObject:mockElement];
	[mockElement release];
}

- (NSArray *)arrayWithElementOfAllTypes {
	NSMutableArray *array = [NSMutableArray array];
	
	[self addElementWithType:kTypeLabelForTests toArray:array];
	[self addElementWithType:kTypeTodoForTests toArray:array];
	[self addElementWithType:kTypeTextViewForTests toArray:array];
	[self addElementWithType:kTypeImageForTests toArray:array];
	return array;
}

- (void)testAmountOfShownElementsInSpace {
	NSArray *array = [self arrayWithElementOfAllTypes];
	rootViewController.componentsFactory = [THCUIComponentsFactory newFactoryWithTextViewDelegate:NULL];
	[rootViewController.componentsFactory registerNewUIComponent:[THCUILabel class] withType:kTypeLabelForTests];
	[rootViewController.componentsFactory registerNewUIComponent:[THCUITodo class] withType:kTypeTodoForTests];
	[rootViewController.componentsFactory registerNewUIComponent:[THCUITextView class] withType:kTypeTextViewForTests];
	[rootViewController.componentsFactory registerNewUIComponent:[THCUIImage class] withType:kTypeImageForTests];
	
	
	[rootViewController showElements:array inView:fakeView];
	
	STAssertEquals([array count], [fakeView.subviews count], @"amount of added elements incorrect");
}

- (NSArray *)arrayWithElementOfType:(NSString *)type {
	NSMutableArray *array = [NSMutableArray array];
	[self addElementWithType:type toArray:array];

	return array;
}

- (void)testImageShownPropely {
	NSArray *array = [self arrayWithElementOfType:kTypeImageForTests];

	id factoryMock = [OCMockObject mockForClass:[THCUIComponentsFactory class]];
	[[[factoryMock expect] andReturn:NULL] addComponentToView:fakeView withElement:[array objectAtIndex:0]];
	rootViewController.componentsFactory = factoryMock;
	[factoryMock release];
	
	[rootViewController showElements:array inView:fakeView];
	
	STAssertNoThrow([factoryMock verify], @"image element should be added as UIImage");
}

- (void)testTodoShownPropely {
	NSArray *array = [self arrayWithElementOfType:kTypeTodoForTests];
	
	id factoryMock = [OCMockObject mockForClass:[THCUIComponentsFactory class]];
	[[[factoryMock expect] andReturn:NULL] addComponentToView:fakeView withElement:[array objectAtIndex:0]];
	rootViewController.componentsFactory = factoryMock;
	[factoryMock release];
	
	[rootViewController showElements:array inView:fakeView];
	
	STAssertNoThrow([factoryMock verify], @"image element should be added as UIImage");
}

- (void)testLabelShownPropely {
	NSArray *array = [self arrayWithElementOfType:kTypeLabelForTests];
	
	id factoryMock = [OCMockObject mockForClass:[THCUIComponentsFactory class]];
	[[[factoryMock expect] andReturn:NULL] addComponentToView:fakeView withElement:[array objectAtIndex:0]];
	rootViewController.componentsFactory = factoryMock;
	[factoryMock release];
	
	[rootViewController showElements:array inView:fakeView];
	
	STAssertNoThrow([factoryMock verify], @"image element should be added as UIImage");
}

- (void)testTextViewShownPropely {
	NSArray *array = [self arrayWithElementOfType:kTypeTextViewForTests];
	
	id factoryMock = [OCMockObject mockForClass:[THCUIComponentsFactory class]];
	[[[factoryMock expect] andReturn:NULL] addComponentToView:fakeView withElement:[array objectAtIndex:0]];
	rootViewController.componentsFactory = factoryMock;
	[factoryMock release];
	
	[rootViewController showElements:array inView:fakeView];
	
	STAssertNoThrow([factoryMock verify], @"image element should be added as UIImage");
}

- (id)elementManagerMock {
	return [OCMockObject mockForClass:[ElementManager class]];
}

- (id)textViewMock {
	return [OCMockObject mockForClass:[THCUITextView class]];
}

- (void)testSubmittingOfEmptyTextViewDeleteElement {
	id elementManagerMock = [self elementManagerMock];
	[[elementManagerMock expect] deleteElement:fakeElement];	
	rootViewController.elementManager = elementManagerMock;
	
	
	id textViewMock = [self textViewMock];
	[[[textViewMock expect] andReturn:fakeElement] element];
	BOOL value = NO;
	[[[textViewMock expect] andReturnValue:OCMOCK_VALUE(value)] hasText];
	
	[rootViewController createComponentIfTextViewIsNotEmpty:textViewMock];
	
	[elementManagerMock verify];
}

- (void)tearDown {
	[fakeElement release];
	[rootViewController release];
	[fakeView release];
}

@end
