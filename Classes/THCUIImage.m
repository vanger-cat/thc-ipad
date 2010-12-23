//
//  THCImage.m
//  thc-ipad
//
//  Created by Vanger on 14.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCUIImage.h"
#import "THCUIComponentsUtils.h"

NSString * const kTypeImage = @"image";

@implementation THCUIImage

@synthesize image;
@synthesize imageName;

+ (THCUIImage *)createInView:(UIView *)view withElement:(id<ElementInterface>)element {
	THCUIImage *thcImage = [[THCUIImage alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
	thcImage.element = element;
	
	[view addSubview:thcImage];
	[thcImage release];
	
	return thcImage;
}

- (THCUIImage *)initWithFrame:(CGRect)frame {
	CGRect frameForSuperView = [THCUIComponentsUtils frameAroundRect:frame withBorder:kBorderWidth];
	[super initWithFrame:frameForSuperView];
	
	image = [[UIImageView alloc] initWithImage:NULL];
	image.frame = CGRectMake(kBorderWidth, kBorderWidth, frame.size.width, frame.size.height);
	[self addSubview:image];
	
	return self;
}

- (CGFloat)x {
	return [THCUIComponentsUtils xOriginInSuperViewOfView:self.image];
}

- (void)setX:(CGFloat)newX {
	[THCUIComponentsUtils changeXOriginOfView:self withNewX:newX ofSubview:self.image];
}

- (CGFloat)y {
	return [THCUIComponentsUtils yOriginInSuperViewOfView:self.image];
}

- (void)setY:(CGFloat)newY {
	[THCUIComponentsUtils changeYOriginOfView:self withNewY:newY ofSubview:self.image];
}

- (NSString *)text {
	return imageName;
}	

- (void)setText:(NSString *)newText {
	if ([newText isEqualToString:self.text])
		return;
	
	self.imageName = newText;
	image.image = [UIImage imageNamed:newText];
	[THCUIComponentsUtils changeSizeOfView:self toSize:CGSizeMake(image.image.size.width + 2 * kBorderWidth, 
																  image.image.size.height + 2 * kBorderWidth)];
	
	[THCUIComponentsUtils changeSizeOfView:image toSize:image.image.size];
}

- (void)setSelected:(BOOL)isSelected {
	[super setSelected:isSelected];
	if (isSelected) {
		self.image.alpha = 0.5;
	}
	else {
		self.image.alpha = 1;
	}
}

- (NSString *)type {
	return kTypeImage;
}

- (void)dealloc {
	[self.imageName release];
	[self.image release];
	[super dealloc];
}

@end
