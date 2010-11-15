//
//  RootViewController.h
//  thc-ipad
//
//  Created by Dmitry Volkov on 12.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RootViewController : UIViewController <UITextViewDelegate> {
	NSMutableArray *textNotes;
	UIScrollView *scrollView;
}

@property (nonatomic, retain) NSMutableArray *textNotes;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

- (UITapGestureRecognizer *)newDoubleTapGestureForLabel;
- (UITapGestureRecognizer *)newDoubleTapGestureForSpace;
- (UILabel *)addTextNoteLabelAtPoint:(CGPoint)point 
							withText:(NSString *)text 
							  toView:(UIView *)aView 
						  andToArray:(NSMutableArray *)anArray;

@end
