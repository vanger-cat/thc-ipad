//
//  THCUIComponentsFactory.h
//  thc-ipad
//
//  Created by Vanger on 14.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ElementInterface.h"
#import "THCUIComponentWithElementProtocol.h"


@interface THCUIComponentsFactory : NSObject {
	id<UITextViewDelegate> textViewDelegate;
}

+ (THCUIComponentsFactory *)newFactoryWithTextViewDelegate:(id<UITextViewDelegate>) textViewDelegate;

@property (nonatomic, retain) id<UITextViewDelegate> textViewDelegate;

- (id<THCUIComponentWithElementProtocol>)addComponentToView:(UIView *)view withElement:(id<ElementInterface>)element;

@end
