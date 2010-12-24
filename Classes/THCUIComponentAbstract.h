//
//  THCUIComponent.h
//  thc-ipad
//
//  Created by Vanger on 25.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THCUIComponentWithElementProtocol.h"

extern const CGFloat kBorderWidth;
extern const CGFloat kTextComponentWidth;
extern const CGFloat kTextComponentHeightMax;

@interface THCUIComponentAbstract : UIView <THCUIComponentWithElementProtocol> {
	id<ElementInterface> element;
	BOOL selected;
}

+ (THCUIComponentAbstract *)createInView:(UIView *)aView withElement:(id<ElementInterface>)newElement;

@end