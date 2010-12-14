//
//  RootViewControllerTest.m
//  thc-ipad
//
//  Created by Vanger on 13.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "GTMSenTestCase.h"
#import "ElementMock.h"
#import "RootViewController.h"
#import "THCUITextViewWithElement.h"
#import "THCUILabelWithElement.h"
#import "THCUIComponentsTestUtils.h"
#import "THCScrollView.h"


#import <OCMock/OCMock.h>
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

	THCUITextViewWithElement *textViewWithElement = (THCUITextViewWithElement *) [fakeView.subviews objectAtIndex:0];
	
	[self assertUIComponent:textViewWithElement 
					   hasX:[THCScrollView getCellCoordinateFromCoordinate:kFakeX]
					   hasY:[THCScrollView getCellCoordinateFromCoordinate:kFakeY] 
					hasText:@"" 
				 isSelected:NO 
				   contains:fakeElement];
}

- (void)testCreationOfLabelInPlaceOfTextViewWithNoElement {
	THCUITextViewWithElement *textViewWithElement = [THCUITextViewWithElement addTextViewToView:fakeView 
																				withElement:fakeElement 
																			   withDelegate:NULL];
	[rootViewController createLabelInPlaceOfTextView:textViewWithElement];
	
	THCUILabelWithElement *label = (THCUILabelWithElement *)[fakeView.subviews objectAtIndex:0];
	[self assertUIComponent:label 
					   hasX:textViewWithElement.x 
					   hasY:textViewWithElement.y 
					hasText:textViewWithElement.text 
				 isSelected:textViewWithElement.selected 
				   contains:fakeElement];

	[fakeElement release];
}

- (void)tearDown {
	[rootViewController release];
	[fakeView release];
}

@end
