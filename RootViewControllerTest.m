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
#import "THCTextViewWithElement.h"
#import "THCLabelWithElement.h"
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
	fakePoint = CGPointMake(fakeX, fakeY);
	fakeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 1000)];
	fakeElement = [ElementMock alloc];
}

- (void)testCreationOfSingleTextViewForNewElement {
	[rootViewController createTextViewAtPoint:fakePoint atView:fakeView withElement:fakeElement];
	
	NSUInteger expectedCount = 1;
	STAssertEquals([fakeView.subviews count], expectedCount, @"New subview is not added to UIView");
}


- (void)testCreationOfTextViewForNewElement {
	[rootViewController createTextViewAtPoint:fakePoint atView:fakeView withElement:fakeElement];

	THCTextViewWithElement *textViewWithElement = (THCTextViewWithElement *) [fakeView.subviews objectAtIndex:0];
	
	[self assertUIComponent:textViewWithElement 
					   hasX:[THCScrollView getCellCoordinateFromCoordinate:fakeX]
					   hasY:[THCScrollView getCellCoordinateFromCoordinate:fakeY] 
					hasText:@"" 
				 isSelected:NO 
				   contains:fakeElement];
}

- (void)testCreationOfLabelInPlaceOfTextViewWithNoElement {
	THCTextViewWithElement *textViewWithElement = [THCTextViewWithElement addTextViewToView:fakeView 
																				withElement:fakeElement 
																			   withDelegate:NULL];
	[rootViewController createLabelInPlaceOfTextView:textViewWithElement];
	
	THCLabelWithElement *label = (THCLabelWithElement *)[fakeView.subviews objectAtIndex:0];
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
