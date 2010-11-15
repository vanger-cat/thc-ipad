//
//  THCElementLabel.m
//  thc-ipad
//
//  Created by Vanger on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCElementLabel.h"


@implementation THCElementLabel

@synthesize element;

- (void)dealloc {
	[element release];
	[super dealloc];
}

@end
