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

+ (void)initSharedInstanceWithContext:(NSManagedObjectContext *)context;
+ (ElementManager *) sharedInstance;

- (Element *)newEmptyAbstractLabel;
- (NSMutableArray *)copyElementsArray;

@end
