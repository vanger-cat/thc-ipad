//
//  ElementManager.m
//  thc-ipad
//
//  Created by Vanger on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "ElementManager.h"


@implementation ElementManager

static ElementManager *sharedInstance;

+ (void)initSharedInstanceWithContext:(NSManagedObjectContext *)context {
	sharedInstance = [ElementManager alloc];
	sharedInstance.managedObjectContext = context;
}

+ (ElementManager *) sharedInstance {
    return sharedInstance;
}

- (Element *)newEmptyAbstractLabel {
	Element * element = (Element *) [NSEntityDescription 
													 insertNewObjectForEntityForName:kAbstractElementEntityName 
													 inManagedObjectContext:self.managedObjectContext];
	[element retain];
	return element;
}

- (NSMutableArray *)copyElementsArray {
	// Fetch
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:kAbstractElementEntityName 
											  inManagedObjectContext:self.managedObjectContext];
	[request setEntity:entity];
	
	NSError *error;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		NSLog(@"%@", [error localizedDescription]);
	}
	[request release];
	
	return mutableFetchResults;
}

@end
