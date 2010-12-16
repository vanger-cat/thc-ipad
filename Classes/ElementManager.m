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

+ (ElementManager *)initSharedInstanceWithContext:(NSManagedObjectContext *)context {
	sharedInstance = [ElementManager alloc];
	sharedInstance.managedObjectContext = context;
	return sharedInstance;
}

+ (ElementManager *)sharedInstance {
    return sharedInstance;
}

- (id<ElementInterface>)newEmptyElement {
	Element * element = (Element *) [NSEntityDescription 
													 insertNewObjectForEntityForName:kElementEntityName 
													 inManagedObjectContext:self.managedObjectContext];
	[element retain];
	return element;
}

- (id<ElementInterface>)saveElement:(Element *)element withText:(NSString *)text atPoint:(CGPoint)point {
	element.text = text;
	element.x = [NSNumber numberWithInt:(int)point.x];
	element.y = [NSNumber numberWithInt:(int)point.y];
	[self save];
		
	return element;
}

- (id<ElementInterface>)savedElementWithText:(NSString *)text atPoint:(CGPoint)point {
	Element *element = [self newEmptyElement];
	[self saveElement:element withText:text atPoint:point];
	[element release];
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

- (void)deleteElement:(id<ElementInterface>)element {
	[self.managedObjectContext deleteObject:element];
}

@end
