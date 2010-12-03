//
//  RootViewController.h
//  thc-ipad
//
//  Created by Dmitry Volkov on 12.11.10.
//  Copyright 2010 Magik Ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THCScrollView.h"
#import "Element.h"
#import "THCTextViewWithElement.h"

@interface RootViewController : UIViewController <UITextViewDelegate, THCScrollViewDelegate> {
	NSMutableArray *textNotes;
	THCScrollView *scrollView;
	
	THCTextViewWithElement *currentTextViewWithElement;
}

@property (nonatomic, retain) IBOutlet THCScrollView *scrollView;
@property (nonatomic, retain) THCTextViewWithElement *currentTextViewWithElement;

- (UITapGestureRecognizer *)newGestureToCreateTextView;

@end
