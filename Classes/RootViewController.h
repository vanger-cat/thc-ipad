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
#import "ElementManager.h"
#import "THCUITextView.h"
#import "DropboxController.h"
#import "THCUIComponentsFactory.h"

@interface RootViewController : UIViewController <UITextViewDelegate, THCScrollViewDelegate> {
	NSMutableArray *textNotes;
	THCScrollView *scrollView;
	DropboxController *dropboxController;
	THCUITextView *currentTextViewWithElement;
	THCUIComponentsFactory *componentsFactory;
	ElementManager *elementManager;
}

@property (nonatomic, retain) IBOutlet THCScrollView *scrollView;
@property (nonatomic, retain) THCUITextView *currentTextViewWithElement;
@property (nonatomic, retain) DropboxController *dropboxController;
@property (nonatomic, retain) THCUIComponentsFactory *componentsFactory;
@property (nonatomic, retain) ElementManager *elementManager;

- (void)showElements:(NSArray *)elements inView:(UIView *)view;
- (UITapGestureRecognizer *)newGestureToCreateTextView;
- (void)createTextViewAtPoint:(CGPoint)pointForTextView atView:(UIView *)view withElement:(id<ElementInterface>)element;
- (IBAction)showDropboxLoginController:(id)sender;

- (void)createComponentIfTextViewIsNotEmpty:(THCUITextView *)textViewWithElement;
- (void)createComponentFromTextView:(THCUITextView *)textViewWithElement;

@end
