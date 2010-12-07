//
//  THCElementLabel.m
//  thc-ipad
//
//  Created by Vanger on 15.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCLabelWithElement.h"
#import "THCFonts.h"
#import "THCColors.h"
#import "THCUIComponentsUtils.h"
#import "THCUITodoView.h"

const CGFloat kMinimalLabelHeight = 18;

@implementation THCLabelWithElement

@synthesize textViewDelegate;
@synthesize label;

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

+ (THCLabelWithElement *)addLabelAtPoint:(CGPoint)newPoint toView:(UIView *)aView withElement:(Element *)newElement withDelegate:(id<UITextViewDelegate>)delegate {
	THCLabelWithElement *thcLabel = [[THCLabelWithElement alloc] initWithFrame:CGRectMake(newPoint.x, newPoint.y, kTextComponentWidth, 0)];
	[THCUIComponentsUtils setupLabel:thcLabel.label];
	
	thcLabel.element = newElement;
	
	UITapGestureRecognizer *convertToTextEditGesture = [self newGestureForConvertingToTextEdit];
	[thcLabel addGestureRecognizer:convertToTextEditGesture];
	[convertToTextEditGesture release];
	
	UITapGestureRecognizer *convertToTODOGesture = [self newGestureForConvertingToTODO];
	[thcLabel addGestureRecognizer:convertToTODOGesture];
	[convertToTODOGesture release];
	
	[aView addSubview:thcLabel];
	
	thcLabel.textViewDelegate = delegate;
	
	[thcLabel release];
	
	NSLog(@"Created new THCLabelWithElement with coordinates %f, %f", thcLabel.frame.origin.x, thcLabel.frame.origin.y);
	return thcLabel;
}

+ (UIGestureRecognizer *)newGestureForConvertingToTextEdit {
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(convertToTextEdit:)];
	tap.numberOfTapsRequired = 2;
	return tap;
}

+ (void)convertToTextEdit:(UITapGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateRecognized) {
		THCLabelWithElement *labelWithElement = (THCLabelWithElement *)gesture.view;

		CGRect rectOfLabelInSpace = [THCUIComponentsUtils getRectInSuperSuperViewOfView:gesture.view];

		[THCTextViewWithElement addTextViewAtPoint:rectOfLabelInSpace.origin 
											toView:labelWithElement.superview 
									   withElement:labelWithElement.element 
									  withDelegate:labelWithElement.textViewDelegate];

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
		THCLabelWithElement *labelWithElement = (THCLabelWithElement *)gesture.view;
		
		CGPoint point = CGPointMake(labelWithElement.frame.origin.x, 
									labelWithElement.frame.origin.y);
		
		[THCUITodoView addTodo:point 
						toView:labelWithElement.superview 
				   withElement:labelWithElement.element 
				  withDelegate:labelWithElement.textViewDelegate];
		
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
	
	self.frame = [THCUIComponentsUtils frameAroundRect:[THCUIComponentsUtils getRectInSuperSuperViewOfView:self.label] 
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

- (void)dealloc {
	[self.textViewDelegate release];
	[self.label release];
	[super dealloc];
}

@end
