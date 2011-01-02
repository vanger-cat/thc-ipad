//
//  THCUIComponentWithElementDelegate.h
//  thc-ipad
//
//  Created by Vanger on 16.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Element.h"


@protocol THCUIComponentWithElementProtocol <NSObject>

@property (nonatomic, retain) id<ElementInterface> element;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, readonly) NSString *type;
@property (nonatomic, retain) id<THCUIComponentWithElementProtocol> topElement;
@property (nonatomic, retain) id<THCUIComponentWithElementProtocol> bottomElement;
@property (nonatomic, retain) id<THCUIComponentWithElementProtocol> leftElement;
@property (nonatomic, retain) id<THCUIComponentWithElementProtocol> rightElement;

- (Element *)saveComponentStateToElement;

@end
