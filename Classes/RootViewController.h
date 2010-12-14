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
#import "THCUITextViewWithElement.h"
#import "DropboxController.h"

@interface RootViewController : UIViewController <UITextViewDelegate, THCScrollViewDelegate> {
	NSMutableArray *textNotes;
	THCScrollView *scrollView;
	DropboxController *dropboxController;
	THCUITextViewWithElement *currentTextViewWithElement;
}

@property (nonatomic, retain) IBOutlet THCScrollView *scrollView;
@property (nonatomic, retain) THCUITextViewWithElement *currentTextViewWithElement;
@property (nonatomic, retain) DropboxController *dropboxController;

- (UITapGestureRecognizer *)newGestureToCreateTextView;
- (void)createTextViewAtPoint:(CGPoint)pointForTextView atView:(UIView *)view withElement:(id<ElementInterface>)element;
- (IBAction)showDropboxLoginController:(id)sender;

- (void)createLabelInPlaceOfTextView:(THCUITextViewWithElement *)textViewWithElement;

@end
