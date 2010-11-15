//
//  AbstractManager.m
//  thc-ipad
//
//  Created by Vanger on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "AbstractManager.h"


@implementation AbstractManager

@synthesize managedObjectContext;

- (NSError *)save {
	NSError *error;
	if (![self.managedObjectContext save:&error]) {
		return error;
	}
	return nil;
}

@end
