//
//  THCUIComponent.m
//  thc-ipad
//
//  Created by Vanger on 25.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCUIComponentAbstract.h"
#import "THCColors.h"
#import "ElementManager.h"

const CGFloat kBorderWidth = 20;
const CGFloat kTextComponentWidth = 60 * 4;
const CGFloat kTextComponentHeightMax = 9999;

@implementation THCUIComponentAbstract

@synthesize element;

- (id)initWithFrame:(CGRect)frame {
	[super initWithFrame:frame];
	self.backgroundColor = [UIColor colorForMarker];
	
	NSLog(@"Created new %@ view with coordinates %f, %f", [self class], frame.origin.x, frame.origin.y);

	return self;
	
}

- (void)setElement:(Element *)newElement {
	if (element == newElement) {
		return;
	}
	
	[newElement retain];
	[element release];
	element = newElement;
	
	self.x = [newElement.x floatValue];
	self.y = [newElement.y floatValue];
	self.text = newElement.text;
}

- (NSString *)text {
	[NSException raise:NSInternalInconsistencyException 
				format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
	return NULL;
}

- (CGFloat)x {
	[NSException raise:NSInternalInconsistencyException 
				format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
	return 0;
}

- (CGFloat)y {
	[NSException raise:NSInternalInconsistencyException 
				format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
	return 0;
}

- (void)setText:(NSString *)newText {
	[NSException raise:NSInternalInconsistencyException 
				format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (void)setX:(CGFloat)newX {
	[NSException raise:NSInternalInconsistencyException 
				format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (void)setY:(CGFloat)newY {
	[NSException raise:NSInternalInconsistencyException 
				format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (Element *)saveComponentStateToElement {
	self.element.text = [self text];
	self.element.x = [NSNumber numberWithFloat:[self x]];
	self.element.y = [NSNumber numberWithFloat:[self y]];
	[[ElementManager sharedInstance] save];
	return self.element;
}

- (BOOL)selected {
	return selected;
}

- (void)setSelected:(BOOL)isSelected {
	selected = isSelected;
}

- (void)dealloc {
	[element release];
	[super dealloc];
}

@end
