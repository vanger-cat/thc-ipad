//
//  ElementInterface.h
//  thc-ipad
//
//  Created by Vanger on 13.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ElementInterface <NSObject>

@required
@property (nonatomic, retain) NSNumber * y;
@property (nonatomic, retain) NSNumber * x;
@property (nonatomic, retain) NSString * text;

@end
