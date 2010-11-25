//
//  THCTodoView.m
//  thc-ipad
//
//  Created by Vanger on 24.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCTodoView.h"


@implementation THCTodoView

@synthesize element;
@synthesize checkbox;
@synthesize label;

- (Element *)saveComponentStateToElement {
	element.x = [NSNumber numberWithInt:self.label.frame.origin.x];
	element.y = [NSNumber numberWithInt:self.label.frame.origin.y];
	element.text = self.label.text;
	
	return element;
}

@end
