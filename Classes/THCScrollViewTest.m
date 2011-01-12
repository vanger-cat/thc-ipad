//
//  THCScrollViewTest.m
//  thc-ipad
//
//  Created by Vanger on 14.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "GTMSenTestCase.h"
#import "THCScrollView.h"



@interface THCScrollViewTest : GTMTestCase
{
	CGFloat coordinateOnTheBorder;
}

@end


@implementation THCScrollViewTest

- (void)setUp {
	coordinateOnTheBorder = 10 * kSizeOfCell;
}

- (void)testConvertationOfCoordinateOnTheBorderToCellCoordinate {
	CGFloat convertedCoordinate = [THCScrollView getCellCoordinateFromCoordinate:coordinateOnTheBorder];
	STAssertEquals(coordinateOnTheBorder, convertedCoordinate, @"Coordinate on the border of cell isn't converted to it self");
}

- (void)testConvertationOfCoordinateCloserToRightBorderToCellCoordinate {
	CGFloat convertedCoordinate = [THCScrollView getCellCoordinateFromCoordinate:(coordinateOnTheBorder + 1)];
	STAssertEquals(coordinateOnTheBorder, convertedCoordinate, @"Coordinate closer to right border isn't converted right border");
}

- (void)testConvertationOfCoordinateCloserToLeftBorderToCellCoordinate {
	CGFloat convertedCoordinate = [THCScrollView getCellCoordinateFromCoordinate:(coordinateOnTheBorder - 1)];
	STAssertEquals((int)coordinateOnTheBorder, (int)convertedCoordinate, @"Coordinate closer to left border isn't converted left border");
}

- (void)testConvertationOfCoordinateInCenterToCellCoordinate {
	CGFloat convertedCoordinate = [THCScrollView getCellCoordinateFromCoordinate:(coordinateOnTheBorder + kSizeOfCell)];
	STAssertEquals(coordinateOnTheBorder + kSizeOfCell, convertedCoordinate, @"Coordinate in the middle of cell isn't converted right border");
}

@end
