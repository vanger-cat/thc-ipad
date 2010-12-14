//
//  THCImageTest.m
//  thc-ipad
//
//  Created by Vanger on 14.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "GTMSenTestCase.h"
#import "ElementMock.h"
#import "THCUIImage.h"
#import "THCUIComponentsTestUtils.h"
#import "THCUIComponentsUtils.h"

NSString * const kFakeImageName = @"vanger.JPG";

@interface THCImageTest : THCUIComponentsTestUtils {
	UIView *fakeView;
	ElementMock *elementMock;
}

@end

@implementation THCImageTest

- (void)setUp {
	fakeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
	elementMock = [THCUIComponentsTestUtils newMockElement];
	elementMock.text = kFakeImageName; 
}

- (void)testAddingOfImageToView {
	[THCUIImage addImageToView:fakeView withElement:elementMock];
	
	NSUInteger expectedCount = 1;
	STAssertEquals([fakeView.subviews count], expectedCount, @"image added incorrectly");
}

- (void)testComponentFieldInAddedImage {
	THCUIImage *image = [THCUIImage addImageToView:fakeView withElement:elementMock];
	
	[self assertUIComponent:image 
					   hasX:kFakeX
					   hasY:kFakeY
					hasText:kFakeImageName 
				 isSelected:NO 
				   contains:elementMock];
}

- (void)testImageNameInAddedComponent {
	THCUIImage *image = [THCUIImage addImageToView:fakeView withElement:elementMock];
	
	STAssertEqualStrings(image.imageName, elementMock.text, @"image name setted incorrectly");
}

- (void)testTHCImageUIImageViewSizeSettedProperly {
	THCUIImage *thcImage = [THCUIImage addImageToView:fakeView withElement:elementMock];
	
	STAssertEquals(thcImage.image.frame.size, thcImage.image.image.size, @"UIImageView size incorrect setted incorrectly");
}

- (void)testTHCImageFrameSizeSettedProperly {
	THCUIImage *thcImage = [THCUIImage addImageToView:fakeView withElement:elementMock];
	
	STAssertEquals(thcImage.frame.size, 
				   [THCUIComponentsUtils frameAroundRect:thcImage.image.frame withBorder:kBorderWidth].size, 
				   @"UIImageView size incorrect setted incorrectly");
}

- (void)tearDown {
	[elementMock release];
	[fakeView release];
}

@end
