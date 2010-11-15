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

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if (objectToDrag) {
		UITouch *touch = [touches anyObject];
		CGPoint point = [touch locationInView:self];
		objectToDrag.frame = CGRectMake(point.x - touchPointInObject.x,
										point.y - touchPointInObject.y,
										objectToDrag.frame.size.width,
										objectToDrag.frame.size.height);
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	objectToDrag.backgroundColor = [UIColor colorForTextNoteBackground];
	objectToDrag = nil;
}

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view {
	UITouch *touch = [touches anyObject];
	touchPointInObject = [touch locationInView:view];
	
	return YES;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
	objectToDrag = view;
	objectToDrag.backgroundColor = [UIColor colorForEditedTextNoteBackground];
	return NO;
}

#pragma mark -
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return nil;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
	
}

@end
