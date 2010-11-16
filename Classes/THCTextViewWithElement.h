//
//  THCTextViewWithElement.h
//  thc-ipad
//
//  Created by Vanger on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Element.h"

@interface THCTextViewWithElement : UITextView {
	Element *element;
}

@property (nonatomic, retain) Element *element;

@end
