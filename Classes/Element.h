//
//  Element.h
//  thc-ipad
//
//  Created by Vanger on 15.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ElementInterface.h"

extern NSString * const kElementEntityName;

@interface Element :  NSManagedObject <ElementInterface> {
}

@end



