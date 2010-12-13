//
//  THCTodoView.m
//  thc-ipad
//
//  Created by Vanger on 24.11.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCUITodoView.h"
#import "THCUIComponentsUtils.h"
#import "THCLabelWithElement.h"


@implementation THCUITodoView

@synthesize checkbox;
@synthesize label;
@synthesize bottomLayer;
@synthesize textViewDelegate;

- (id)initWithFrame:(CGRect)frame {
	CGRect viewFrame = [THCUIComponentsUtils frameAroundRect:frame withBorder:kBorderWidth];
	
	[super initWithFrame:viewFrame];
	
	CGRect labelFrame = CGRectMake(0, 
								   0, 
								   frame.size.width, 
								   frame.size.height);
	self.label = [[UILabel alloc] initWithFrame:labelFrame];
	
	self.checkbox = [[UISwitch alloc] initWithFrame:CGRectMake(0, 
															   labelFrame.size.height, 
															   frame.size.width, 
															   0)];
	[self.checkbox setOn:NO animated:YES];
	
	self.bottomLayer = [[UIView alloc] initWithFrame:CGRectMake(kBorderWidth, 
															    kBorderWidth, 
															    frame.size.width, 
																labelFrame.size.height + self.checkbox.frame.size.height)];
	[self.bottomLayer addSubview:self.label];
	[self.bottomLayer addSubview:self.checkbox];
	[self addSubview:self.bottomLayer];
	
	return self;
}

+ (THCUITodoView *)addTodo:(CGPoint)point toView:(UIView *)aView withElement:(Element *)newElement withDelegate:(id<UITextViewDelegate>)delegate {
	THCUITodoView *todo = [[THCUITodoView alloc] initWithFrame:CGRectMake(point.x, point.y, kTextComponentWidth, 0)];
	[THCUIComponentsUtils setupLabel:todo.label];
	
	todo.element = newElement;
	
	[aView addSubview:todo];
	
	UIGestureRecognizer *convertToLabelGesture = [self newGestureForConvertingToLabel];
	[todo addGestureRecognizer:convertToLabelGesture];
	[convertToLabelGesture release];
	
	[todo release];

	todo.textViewDelegate = delegate;
	
	return todo;
}

+ (UIGestureRecognizer *)newGestureForConvertingToLabel {
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(convertToLabel:)];
	tap.numberOfTapsRequired = 1;
	tap.numberOfTouchesRequired = 2;
	return tap;
}

+ (void)convertToLabel:(UITapGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateRecognized) {
		THCUITodoView *todo = (THCUITodoView *)gesture.view;
		
		[THCLabelWithElement addLabelToView:todo.superview
								withElement:todo.element 
							   withDelegate:todo.textViewDelegate];
		
		[todo removeFromSuperview];
	}
}

- (CGFloat)x {
	return [THCUIComponentsUtils xOriginInSuperViewOfView:self.bottomLayer];
}

- (void)setX:(CGFloat)newX {
	[THCUIComponentsUtils changeXOriginOfView:self withNewX:newX ofSubview:self.bottomLayer];
}

- (CGFloat)y {
	return [THCUIComponentsUtils yOriginInSuperViewOfView:self.bottomLayer];
}

- (void)setY:(CGFloat)newY {
	[THCUIComponentsUtils changeYOriginOfView:self withNewY:newY ofSubview:self.bottomLayer];
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
	
	CGRect newCheckboxRect = self.checkbox.frame;
	newCheckboxRect.origin.y = self.label.frame.origin.y + self.label.frame.size.height;
	self.checkbox.frame = newCheckboxRect;
	
	self.bottomLayer.frame = CGRectMake(self.bottomLayer.frame.origin.x, 
										self.bottomLayer.frame.origin.x, 
										self.bottomLayer.frame.size.width, 
										self.label.frame.size.height + self.checkbox.frame.size.height);
	self.frame = [THCUIComponentsUtils frameAroundRect:[THCUIComponentsUtils rectInSuperSuperViewOfView:self.bottomLayer] 
											withBorder:kBorderWidth]; 
}

- (void)dealloc {
	[bottomLayer release];
	[checkbox release];
	[label release];
	[textViewDelegate release];
	[super dealloc];
}

@end
