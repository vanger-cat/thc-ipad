//
//  THCScrollView.h
//  thc-ipad
//
//  Created by Dmitry Volkov on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface THCScrollView : UIScrollView <UIScrollViewDelegate> {
	UIView *objectToDrag;
	CGPoint touchPointInObject;
	UIView *spaceView;
}

@property (nonatomic, retain) UIView *spaceView;

@end
