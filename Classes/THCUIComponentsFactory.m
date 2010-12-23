//
//  THCUIComponentsFactory.m
//  thc-ipad
//
//  Created by Vanger on 14.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCUIComponentsFactory.h"
#import "THCUIComponentAbstract.h"

//TODO: test it!
@implementation THCUIComponentsFactory 
@synthesize textViewDelegate;
//TODO: rename
+ (THCUIComponentsFactory *)newFactoryWithTextViewDelegate:(id<UITextViewDelegate>) textViewDelegate {
	return [[THCUIComponentsFactory alloc] initWithTextViewDelegate:textViewDelegate];
}

- (THCUIComponentsFactory *)initWithTextViewDelegate:(id<UITextViewDelegate>) delegate {
	UIComponentsByNames = [[NSMutableDictionary alloc] initWithCapacity:0];
	[delegate retain];
	self.textViewDelegate = delegate;
	
	return self;
}

- (void)registerNewUIComponent:(id)component withType:(NSString *)type {
	[UIComponentsByNames setObject:component forKey:type];
}

//TODO: reimplement this to remove warnings!
- (id<THCUIComponentWithElementProtocol>)addComponentToView:(UIView *)view withElement:(id<ElementInterface>)element {
	id componentClass = [UIComponentsByNames objectForKey:element.type];
	if (componentClass) {
		if ([componentClass respondsToSelector:@selector(createInView:withElement:)]) {
			return [((THCUIComponentAbstract *) componentClass) createInView:view withElement:element];
		} else {
			return [((THCUIComponentAbstract *) componentClass) createInView:view 
																 withElement:element 
																withDelegate:self.textViewDelegate];
		}
		
		//TODO: test it
		NSLog(@"Can't find creation method for type '%@'", element.type);
		[NSException raise:@"Can't find creation method" format:@"Can't find creation method for type '%@'", element.type];
		return NULL;
	}
		
	NSLog(@"Unknown element.type '%@'", element.type);
	[NSException raise:@"Invalid argument" format:@"Unknown element.type '%@'", element.type];
	return NULL;
}

- (void)dealloc {
	[self.textViewDelegate release];
	[UIComponentsByNames release];
	[super dealloc];
}

@end
