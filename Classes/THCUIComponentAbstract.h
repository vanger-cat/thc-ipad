//
//  THCUIComponent.h
//  thc-ipad
//
//  Created by Vanger on 25.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THCUIComponentWithElementDelegate.h"

extern const CGFloat kBorderWidth;
extern const CGFloat kTextComponentWidth;
extern const CGFloat kTextComponentHeightMax;

@interface THCUIComponentAbstract : UIView <THCUIComponentWithElementDelegate> {
	Element *element;
	BOOL selected;
}

@end
