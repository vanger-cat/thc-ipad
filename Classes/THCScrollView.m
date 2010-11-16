//
//  THCScrollView.m
//  thc-ipad
//
//  Created by Dmitry Volkov on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCScrollView.h"
#import "THCColors.h"

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
	objectToDrag.backgroundColor = [UIColor colorForTextNoteBackground];
	[self.thcDelegate scrollView:self touchEnded:objectToDrag];
	objectToDrag = nil;
}

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view {
	UITouch *touch = [touches anyObject];
	touchPointInObject = [touch locationInView:view];
	return YES;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
	if (view != spaceView) {
		objectToDrag = view;
		objectToDrag.backgroundColor = [UIColor colorForEditedTextNoteBackground];
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
