//
//  Utils.m
//  thc-ipad
//
//  Created by Dmitry Volkov on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "Utils.h"


@implementation Utils

int randomIntValueFrom(int startValue, int finishValue) {
	int value = (arc4random() % (finishValue - startValue + 1)) + startValue;
	return value;
}

@end
