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
	NSMutableDictionary *UIComponentsByNames;
}

@property (nonatomic, retain) id<UITextViewDelegate> textViewDelegate;

+ (THCUIComponentsFactory *)newFactoryWithTextViewDelegate:(id<UITextViewDelegate>) textViewDelegate;
- (void)registerNewUIComponent:(id)component withType:(NSString *)type;

- (id<THCUIComponentWithElementProtocol>)addComponentToView:(UIView *)view withElement:(id<ElementInterface>)element;
- (THCUIComponentsFactory *)initWithTextViewDelegate:(id<UITextViewDelegate>) textViewDelegate;

@end
