//
//  THCUIComponentAbstractFake.m
//  thc-ipad
//
//  Created by Vanger on 02.01.11.
//  Copyright 2011 Magic Ink. All rights reserved.
//

#import "THCUIComponentAbstractFake.h"


@implementation THCUIComponentAbstractFake 
	
@synthesize x;
@synthesize y;
@synthesize text;
@synthesize type;

+ (THCUIComponentAbstractFake *)newComponentWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height {
	return [[THCUIComponentAbstractFake alloc] initWithFrame:CGRectMake(x, y, width, height)];
}

@end
