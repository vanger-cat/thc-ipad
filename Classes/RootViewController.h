//
//  RootViewController.h
//  thc-ipad
//
//  Created by Dmitry Volkov on 12.11.10.
//  Copyright 2010 Magik Ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THCScrollView.h"

@interface RootViewController : UIViewController <UITextViewDelegate> {
	THCScrollView *scrollView;
}

@property (nonatomic, retain) IBOutlet THCScrollView *scrollView;

- (UITapGestureRecognizer *)newDoubleTapGestureForLabel;
- (UITapGestureRecognizer *)newDoubleTapGestureForSpace;
- (UILabel *)newTextNoteLabelAtPoint:(CGPoint)point 
							withText:(NSString *)text;

@end
