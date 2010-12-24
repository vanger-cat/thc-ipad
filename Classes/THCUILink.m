//
//  THCUILink.m
//  thc-ipad
//
//  Created by Vanger on 24.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "THCUILink.h"
#import "THCFonts.h"
#import "THCColors.h"

NSString * const kTypeLink = @"link";

@implementation THCUILink

+ (THCUILink *)createInView:(UIView *)aView withElement:(id<ElementInterface>)newElement {
	THCUILink *thcLink = [[THCUILink alloc] initWithFrame:[[self class] frameForLabelWithElement:newElement]];
	[super addLabel:thcLink toView:aView withElement:newElement];
	
	UIGestureRecognizer *gestureToOpenLink = [THCUILink newGestureToOpenLink];
	[thcLink addGestureRecognizer:gestureToOpenLink];
	[gestureToOpenLink release];
	
	[thcLink.label setFont:[UIFont fontForLink]];
	[thcLink.label setTextColor:[UIColor colorForLinkTextColor]];
	
	return thcLink;
}

+ (UIGestureRecognizer *)newGestureToOpenLink {
	UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openLink:)];
	gestureRecognizer.numberOfTouchesRequired = 3;
	return gestureRecognizer;
}

+ (void)openLink:(UIGestureRecognizer *)gesture {
	if (gesture.state != UIGestureRecognizerStateRecognized) {
		return;
	}
	THCUILink *link = (THCUILink *)gesture.view;
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:link.url]];
}

- (id)initWithFrame:(CGRect)frame {
	[super initWithFrame:frame];
		
	return self;
}

- (void)setUrl:(NSString *)url {
	self.text = url;
}

- (NSString *)url {
	return self.text;
}

- (NSString *)type {
	return kTypeLink;
}

@end
