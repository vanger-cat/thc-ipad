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

@synthesize topElement;
@synthesize bottomElement;
@synthesize leftElement;
@synthesize rightElement;

+ (THCUIComponentAbstract *)createInView:(UIView *)aView withElement:(id<ElementInterface>)newElement {
	[NSException raise:NSInternalInconsistencyException 
				format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
	return NULL;
}

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
	//???: is this necessary?
	newElement.type = [self type];
	
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

- (NSString *)type {
	[NSException raise:NSInternalInconsistencyException 
				format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
	return 0;
}

- (Element *)saveComponentStateToElement {
	self.element.text = [self text];
	self.element.x = [NSNumber numberWithFloat:[self x]];
	self.element.y = [NSNumber numberWithFloat:[self y]];
	self.element.type = [self type];
	[[ElementManager sharedInstance] save];
	return self.element;
}

- (BOOL)selected {
	return selected;
}

- (CGFloat) width {
	return self.frame.size.width - 2 * kBorderWidth;
}

- (CGFloat) height {
	return self.frame.size.height - 2 * kBorderWidth;
}


- (void)setSelected:(BOOL)isSelected {
	selected = isSelected;
}

- (BOOL)isMyLeftTopCornerIn:(THCUIComponentAbstract *)component {
	BOOL isInsideByXAxis = self.x >= component.x && self.x <= (component.x + component.width);
    
    NSLog(@"Self: %f, %f", self.x, self.y);
    NSLog(@"Comp: %f, %f", component.x, component.y);
    
    isInsideByXAxis ? NSLog(@"YES") : NSLog(@"NO");
	BOOL isInsideByYAxis = self.y >= component.y && self.y <= (component.y + component.height);
    isInsideByYAxis ? NSLog(@"YES") : NSLog(@"NO");	

    return isInsideByXAxis && isInsideByYAxis;
}

- (BOOL)isConnectableFromRightTo:(THCUIComponentAbstract *)component {
    return YES;
}

- (void)connectIfPossibleToComponent:(THCUIComponentAbstract *)component {
	if (self == component) {
		return;
	}
	
	if ([self isMyLeftTopCornerIn:component]) {
        if ([self isConnectableFromRightTo:component]) {
            self.leftElement = component;
            component.rightElement = self;
        }
		self.topElement = component;
		component.bottomElement = self;
		NSLog(@"Connected!");
	} else {
		NSLog(@"Not Connected!");
	}
}

- (void)connectIfPossibleWithComponents:(NSArray *)components withCellSize:(CGFloat)cellSize {
	id component = nil;
	NSLog(@"Started analization of connections");
	self.topElement = nil;
	self.leftElement = nil;
	self.rightElement = nil;
	self.bottomElement = nil;
	for (component in components) {
		if ([component isKindOfClass:[THCUIComponentAbstract class]]) {
			[self connectIfPossibleToComponent:component];
		}
	}
	
	if (self.topElement != nil) {
		self.x = self.topElement.x;
		self.y = self.topElement.y + self.topElement.height;
	}
}

- (void)dealloc {
	[element release];
	[super dealloc];
}

@end
