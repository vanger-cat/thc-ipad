//
//  RootViewController.h
//  thc-ipad
//
//  Created by Dmitry Volkov on 12.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THCScrollView.h"
#import "Element.h"

@interface RootViewController : UIViewController <UITextViewDelegate> {
	NSMutableArray *textNotes;
	THCScrollView *scrollView;
}

@property (nonatomic, retain) NSMutableArray *textNotes;
@property (nonatomic, retain) IBOutlet THCScrollView *scrollView;

- (UITapGestureRecognizer *)newDoubleTapGestureForLabel;
- (UITapGestureRecognizer *)newDoubleTapGestureForSpace;

@end
