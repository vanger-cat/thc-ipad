//
//  THCImage.h
//  thc-ipad
//
//  Created by Vanger on 14.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THCUIComponentAbstract.h"
#import "ElementInterface.h"

extern NSString * const kTypeImage;

@interface THCUIImage : THCUIComponentAbstract {
	UIImageView *image;
	NSString *imageName;
}

@property (nonatomic, retain) UIImageView *image;
@property (nonatomic, retain) NSString *imageName;

+ (THCUIImage *)createInView:(UIView *)view withElement:(id<ElementInterface>)element;

@end
