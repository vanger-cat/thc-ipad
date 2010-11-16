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

- (Element *)newEmptyElement {
	Element * element = (Element *) [NSEntityDescription 
													 insertNewObjectForEntityForName:kElementEntityName 
													 inManagedObjectContext:self.managedObjectContext];
	[element retain];
	return element;
}

- (NSMutableArray *)copyElementsArray {
	// Fetch
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:kElementEntityName 
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

- (void)saveElement:(Element *)element withText:(NSString *)text atPoint:(CGPoint)point {
	element.text = text;
	element.x = [NSNumber numberWithInt:(int)point.x];
	element.y = [NSNumber numberWithInt:(int)point.y];
	[self save];
	
}

- (Element *)newSavedElementWithText:(NSString *)text atPoint:(CGPoint)point {
	Element *element = [self newEmptyElement];
	[self saveElement:element withText:text atPoint:point];
	return element;
}

@end
