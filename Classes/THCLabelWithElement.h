//
//  THCElementLabel.h
//  thc-ipad
//
//  Created by Vanger on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Element.h"
#import "THCUIComponentWithElementDelegate.h"
#import "THCTextViewWithElement.h"

extern const CGFloat kTextAndLabelXDifference;
extern const CGFloat kTextAndLabelYDifference;

extern const CGFloat kTextNoteWidth;
extern const CGFloat kTextNoteHeight;
extern const CGFloat kTextNoteHeightMax;

@interface THCLabelWithElement : UILabel <THCUIComponentWithElementDelegate> {
	Element *element;
	
	id<UITextViewDelegate> textViewDelegate;
}

@property (nonatomic, retain) id<UITextViewDelegate> textViewDelegate;

+ (UILabel *)addLabelAtPoint:(CGPoint)point withText:(NSString *)text toView:(UIView *)aView withElement:(Element *)newElement withDelegate:(id<UITextViewDelegate>)delegate;

+ (UITapGestureRecognizer *)newDoubleTapGestureForLabel;

@end
