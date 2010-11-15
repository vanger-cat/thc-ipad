//
//  Element.h
//  thc-ipad
//
//  Created by Vanger on 15.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

extern NSString * const kAbstractElementEntityName;

@interface Element :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * y;
@property (nonatomic, retain) NSNumber * x;
@property (nonatomic, retain) NSString * text;

@end



