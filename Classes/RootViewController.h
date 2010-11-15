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
	NSMutableArray *textNotes;
	THCScrollView *scrollView;
}

@property (nonatomic, retain) NSMutableArray *textNotes;
@property (nonatomic, retain) IBOutlet THCScrollView *scrollView;

- (UITapGestureRecognizer *)newDoubleTapGestureForLabel;
- (UITapGestureRecognizer *)newDoubleTapGestureForSpace;
- (UILabel *)addTextNoteLabelAtPoint:(CGPoint)point 
							withText:(NSString *)text 
							  toView:(UIView *)aView;

@end
