//
//  THCElementLabel.h
//  thc-ipad
//
//  Created by Vanger on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Element.h"

@interface THCLabelWithElement : UILabel {
	Element *element;
}

@property (nonatomic, retain) Element *element;

@end
