//
//  THCFonts.m
//  thc-ipad
//
//  Created by Dmitry Volkov on 14.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCFonts.h"

const int kFontSize = 14;

@implementation UIFont (THCFonts)

+ (UIFont *)fontForTextNote {
	return [UIFont systemFontOfSize:kFontSize];
}

+ (UIFont *)fontForLink {
	return [UIFont italicSystemFontOfSize:kFontSize];
}

@end
