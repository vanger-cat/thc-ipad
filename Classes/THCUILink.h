//
//  THCUILink.h
//  thc-ipad
//
//  Created by Vanger on 24.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THCUILabel.h"

extern NSString * const kTypeLink;

@interface THCUILink : THCUILabel {
	
}

@property (nonatomic, retain) NSString *url;

+ (THCUILink *)createInView:(UIView *)aView withElement:(id<ElementInterface>)newElement;
+ (UIGestureRecognizer *)newGestureToOpenLink;
@end
