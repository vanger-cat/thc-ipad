//
//  THCUILinkTest.m
//  thc-ipad
//
//  Created by Vanger on 24.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCUIComponentsTestUtils.h"
#import "THCUILink.h"

@interface THCUILinkTest : THCUIComponentsTestUtils
{
	UIView *fakeView;
	id<ElementInterface> fakeElement;
}

@end

@implementation THCUILinkTest

- (void)setUp {
	fakeView = [THCUIComponentsTestUtils newEmptyView];
	fakeElement = [THCUIComponentsTestUtils newMockElement];
}

- (void)testCreatedLinkAddedToView {
	[THCUILink createInView:fakeView withElement:fakeElement withDelegate:NULL];
	
	NSUInteger expectedCount = 1;
	STAssertEquals([[fakeView subviews] count], expectedCount, @"created component is not added necessary view");
}

- (void)testCreationInView {
	[THCUILink createInView:fakeView withElement:fakeElement withDelegate:NULL];
	
	id component = [[fakeView subviews] objectAtIndex:0];
	STAssertTrue([component isMemberOfClass:[THCUILink class]], @"created component is not instance of THCUILink");
}

- (void)testCreatedLinkInititedWithElementProperly {
	THCUILink *link = [THCUILink createInView:fakeView withElement:fakeElement withDelegate:NULL];
	[self assertUIComponent:link 
					   hasX:kFakeX
					   hasY:kFakeY
					hasText:kFakeText
				 isSelected:kDefaultIsSelectedState 
				   contains:fakeElement];
}

- (void)testCreatedLinkContainsRightLink {
	THCUILink *link = [THCUILink createInView:fakeView withElement:fakeElement withDelegate:NULL];
	STAssertEqualStrings(link.url, fakeElement.text, @"url of the link should be equal to text of element");
}

- (void)testOpenLinkGestureTargetedToExistingMethod {
	STAssertTrue([[THCUILink class] respondsToSelector:@selector(openLink:)], @"can't find methods for opening new link");
}

- (void)testElementTypeAfterCreation {
	THCUILink *link = [THCUILink createInView:fakeView withElement:fakeElement withDelegate:NULL];
	STAssertEqualStrings(link.element.type, kTypeLinkForTests, @"type of element isn't set");
}

- (void)tearDown {
	[fakeElement release];
	[fakeView release];
}

@end
