//
//  DropboxController.h
//  thc-ipad
//
//  Created by Dmitry Volkov on 08.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DropboxSDK.h"

@interface DropboxController : NSObject <DBRestClientDelegate> {
	DBRestClient *restClient;
	NSString* filesHash;
	BOOL working;
}

@property (nonatomic, readonly) DBRestClient* restClient;

@end
