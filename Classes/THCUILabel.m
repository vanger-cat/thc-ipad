//
//  THCElementLabel.m
//  thc-ipad
//
//  Created by Vanger on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCUILabel.h"
#import "THCFonts.h"
#import "THCColors.h"
#import "THCUIComponentsUtils.h"
#import "THCUITodo.h"

NSString * const kTypeLabel = @"label";
const CGFloat kMinimalLabelHeight = 18;

@implementation THCUILabel

@synthesize label;

+ (THCUILabel *)createInView:(UIView *)aView withElement:(id<ElementInterface>)newElement {
	THCUILabel *thcLabel = [[THCUILabel alloc] initWithFrame:[[self class] frameForLabelWithElement:newElement]];
	return [self addLabel:thcLabel toView:aView withElement:newElement];
}

+ (CGRect)frameForLabelWithElement:(id<ElementInterface>)element {
	return CGRectMake([element.x intValue], [element.y intValue], kTextComponentWidth, 0);
}

+ (THCUILabel *)addLabel:(THCUILabel *)thcLabel toView:(UIView *)aView withElement:(id<ElementInterface>)newElement {
	[THCUIComponentsUtils setupLabel:thcLabel.label];
	
	thcLabel.element = newElement;
	
	UITapGestureRecognizer *convertToTextEditGesture = [self newGestureForConvertingToTextEdit];
	[thcLabel addGestureRecognizer:convertToTextEditGesture];
	[convertToTextEditGesture release];
	
	UITapGestureRecognizer *convertToTODOGesture = [self newGestureForConvertingToTODO];
	[thcLabel addGestureRecognizer:convertToTODOGesture];
	[convertToTODOGesture release];
	
	[aView addSubview:thcLabel];
	
	[thcLabel release];
	
	return thcLabel;
}


- (id)initWithFrame:(CGRect)frame {
	CGRect viewFrame = [THCUIComponentsUtils frameAroundRect:frame withBorder:kBorderWidth];
	
	[super initWithFrame:viewFrame];
	
	CGRect labelFrame = CGRectMake(kBorderWidth, 
								   kBorderWidth, 
								   frame.size.width, 
								   frame.size.height);
	self.label = [[UILabel alloc] initWithFrame:labelFrame];
	[self addSubview:self.label];
	
	return self;
}

+ (UIGestureRecognizer *)newGestureForConvertingToTextEdit {
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(convertToTextEdit:)];
	tap.numberOfTapsRequired = 2;
	return tap;
}

+ (void)convertToTextEdit:(UITapGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateRecognized) {
		THCUILabel *labelWithElement = (THCUILabel *)gesture.view;

		[THCUITextView createInView:labelWithElement.superview 
									  withElement:labelWithElement.element];

		[labelWithElement removeFromSuperview];
	}
}

+ (UIGestureRecognizer *)newGestureForConvertingToTODO {
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(convertToTODO:)];
	tap.numberOfTapsRequired = 1;
	tap.numberOfTouchesRequired = 2;
	return tap;
}

+ (void)convertToTODO:(UITapGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateRecognized) {
		THCUILabel *labelWithElement = (THCUILabel *)gesture.view;
				
		[THCUITodo createInView:labelWithElement.superview
						 withElement:labelWithElement.element];
		
		[labelWithElement removeFromSuperview];
	}
}

- (CGFloat)x {
	return [THCUIComponentsUtils xOriginInSuperViewOfView:self.label];
}

- (void)setX:(CGFloat)newX {
	[THCUIComponentsUtils changeXOriginOfView:self withNewX:newX ofSubview:self.label];
}

- (CGFloat)y {
	return [THCUIComponentsUtils yOriginInSuperViewOfView:self.label];
}

- (void)setY:(CGFloat)newY {
	[THCUIComponentsUtils changeYOriginOfView:self withNewY:newY ofSubview:self.label];
}

- (NSString *)text {
	return self.label.text;
}	

- (void)setText:(NSString *)newText {
	if ([self.label.text isEqualToString:newText]) {
		return;
	}
	
	self.label.text = newText;
	[THCUIComponentsUtils resizeLabel:self.label 
					withMinimalHeight:kMinimalLabelHeight
					 andMaximalHeight:kTextComponentHeightMax];
	
	self.frame = [THCUIComponentsUtils frameAroundRect:[THCUIComponentsUtils rectInSuperSuperViewOfView:self.label] 
											withBorder:kBorderWidth]; 
}

- (void)setSelected:(BOOL)isSelected {
	[super setSelected:isSelected];
	if (isSelected) {
		self.label.backgroundColor = [UIColor colorForEditedTextNoteBackground];
	}
	else {
		self.label.backgroundColor = [UIColor colorForTextNoteBackground];
	}
}

- (NSString *)type {
	return kTypeLabel;
}

- (void)dealloc {
	[self.label release];
	[super dealloc];
}

@end
