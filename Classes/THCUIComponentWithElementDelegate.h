//
//  THCUIComponentWithElementDelegate.h
//  thc-ipad
//
//  Created by Vanger on 16.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol THCUIComponentWithElementDelegate

@property (nonatomic, retain) Element *element;

- (Element *)saveComponentStateToElement;

@end
