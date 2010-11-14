//
//  THCColors.m
//  thc-ipad
//
//  Created by Dmitry Volkov on 14.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCColors.h"

@implementation UIColor (THCColors)

+ (UIColor *)colorForEditedTextNoteBackground {
	return [UIColor colorWithRed:255 green:255 blue:255 alpha:0.2];
}

+ (UIColor *)colorForTextNoteBackground {
	return [UIColor clearColor];
}

@end
