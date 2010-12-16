//
//  ElementManager.h
//  thc-ipad
//
//  Created by Vanger on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Element.h"
#import "AbstractManager.h"

@interface ElementManager : AbstractManager {
	
}

+ (ElementManager *)initSharedInstanceWithContext:(NSManagedObjectContext *)context;
+ (ElementManager *)sharedInstance;

- (id<ElementInterface>)newEmptyElement;
- (id<ElementInterface>)savedElementWithText:(NSString *)text atPoint:(CGPoint)point;
- (id<ElementInterface>)saveElement:(Element *)element withText:(NSString *)text atPoint:(CGPoint)point;
- (NSMutableArray *)copyElementsArray;
- (void)deleteElement:(id<ElementInterface>)element;

@end
