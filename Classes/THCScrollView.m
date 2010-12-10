//
//  THCScrollView.m
//  thc-ipad
//
//  Created by Dmitry Volkov on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCScrollView.h"
#import "THCColors.h"
#import "THCUIComponentsUtils.h"

const CGFloat kSizeOfCell = 20;

@implementation THCScrollView

@synthesize thcDelegate;
@synthesize spaceView;

- (UIView *)spaceView {
	if (!spaceView) {
		spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)];
		spaceView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
		[self addSubview:spaceView];
		[spaceView release];
	}
	return spaceView;
}

+ (void)changePositionWithAdjustmentByGridOfComponent:(THCUIComponentAbstract *)component toPoint:(CGPoint)point animated:(BOOL)animated {
		//TODO: uncomment
	if (animated) {
		[UIView beginAnimations:@"Move" context:nil];
		[UIView setAnimationDuration:0.2];
		[UIView setAnimationBeginsFromCurrentState:YES];
	}	
		
	component.x = round((point.x) / kSizeOfCell) * kSizeOfCell - kBorderWidth;
	component.y = round((point.y) / kSizeOfCell) * kSizeOfCell - kBorderWidth;
	
	component.x = point.x;
	component.y = point.y;
	
	if (animated) {	
		[UIView commitAnimations];
	}
	[component saveComponentStateToElement];
}

#pragma mark Touches

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if (objectToDrag) {
		UITouch *touch = [touches anyObject];
		CGPoint point = [touch locationInView:self.spaceView];
		objectToDrag.frame = CGRectMake(point.x - touchPointInObject.x,
										point.y - touchPointInObject.y,
										objectToDrag.frame.size.width,
										objectToDrag.frame.size.height);
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self.spaceView];

	
	THCUIComponentAbstract *component = (THCUIComponentAbstract *)objectToDrag;
	CGPoint newPoint = CGPointMake(point.x - touchPointInObject.x + kBorderWidth, 
								   point.y - touchPointInObject.y + kBorderWidth);
	[THCScrollView changePositionWithAdjustmentByGridOfComponent:component 
														 toPoint:newPoint 
														animated:YES];
	
	component.selected = NO;
	[self.thcDelegate scrollView:self touchEnded:objectToDrag];
	objectToDrag = nil;
}

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view {
	UITouch *touch = [touches anyObject];
	
	touchPointInObject = [touch locationInView:[THCUIComponentsUtils getBasicComponentOf:view]];
	return YES;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
	if (view != spaceView) {
		THCUIComponentAbstract *component = [THCUIComponentsUtils getBasicComponentOf:view];
		objectToDrag = component;
		component.selected = YES;
		return NO;
	} else {
		return YES;
	}
}

#pragma mark -
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return self.spaceView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
}

- (void)dealloc {
	[spaceView release];
	[super dealloc];
}

@end
