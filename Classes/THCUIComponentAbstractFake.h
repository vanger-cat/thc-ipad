//
//  THCUIComponentAbstractFake.h
//  thc-ipad
//
//  Created by Vanger on 02.01.11.
//  Copyright 2011 Magic Ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THCUIComponentAbstract.h"

@interface THCUIComponentAbstractFake : THCUIComponentAbstract {
	CGFloat x;
	CGFloat y;
	NSString *text;
	NSString *type;
}

+ (THCUIComponentAbstractFake *)newComponentWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height;

@end
