//
//  ElementMock.h
//  thc-ipad
//
//  Created by Vanger on 13.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ElementInterface.h"

@interface ElementMock : NSObject <ElementInterface> {
	NSNumber *y;
	NSNumber *x;
	NSString *text;
	
	NSNumber *isChecked;
	NSString *type;
}

@end
