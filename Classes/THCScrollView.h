//
//  THCScrollView.h
//  thc-ipad
//
//  Created by Dmitry Volkov on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@class THCScrollView;

@protocol THCScrollViewDelegate

- (void)scrollView:(THCScrollView *)scrollView touchEnded:(UIView *)draggedObject;

@end


@interface THCScrollView : UIScrollView <UIScrollViewDelegate> {
	UIView *objectToDrag;
	CGPoint touchPointInObject;
	UIView *spaceView;
	id<THCScrollViewDelegate> delegate;
}

@property (nonatomic, retain) id<THCScrollViewDelegate> thcDelegate;
@property (nonatomic, retain) UIView *spaceView;

@end
