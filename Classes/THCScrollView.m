//
//  THCScrollView.m
//  thc-ipad
//
//  Created by Dmitry Volkov on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCScrollView.h"
#import "THCColors.h"
#import "THCUIComponentAbstract.h"
#import "THCUIComponentsUtils.h"

const int kSizeOfCell = 20;

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
	[UIView beginAnimations:@"Move" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationBeginsFromCurrentState:YES];
	
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self.spaceView];
	objectToDrag.frame = CGRectMake((int)(point.x - touchPointInObject.x) / kSizeOfCell * kSizeOfCell,
									(int)(point.y - touchPointInObject.y) / kSizeOfCell * kSizeOfCell,
									objectToDrag.frame.size.width,
									objectToDrag.frame.size.height);
	
	THCUIComponentAbstract *component = (THCUIComponentAbstract *)objectToDrag;
	component.selected = NO;
	[UIView commitAnimations];
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
