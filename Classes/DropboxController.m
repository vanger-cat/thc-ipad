//
//  DropboxController.m
//  thc-ipad
//
//  Created by Dmitry Volkov on 08.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "DropboxController.h"


@implementation DropboxController

- (DBRestClient*)restClient {
	if (!restClient) {
		restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
		restClient.delegate = self;
	}
	return restClient;
}

- (id)init {
	self = [super init];
    if (self) {
         [self loadFiles];
    }
    return self;
}

#pragma mark DBRestClientDelegate
- (void)restClient:(DBRestClient*)client 
	loadedMetadata:(DBMetadata*)metadata {
	
	NSLog(@"Loaded metadata!");
}

- (void)restClient:(DBRestClient*)client metadataUnchangedAtPath:(NSString*)path {
	
	NSLog(@"Metadata unchanged!");
}

- (void)restClient:(DBRestClient*)client loadMetadataFailedWithError:(NSError*)error {
	
	NSLog(@"Error loading metadata: %@", error);
}

#pragma mark -

- (void)setWorking:(BOOL)isWorking {
    if (working == isWorking) return;
    working = isWorking;
    
    if (working) {
        //[activityIndicator startAnimating];
    } else { 
        //[activityIndicator stopAnimating];
    }
    //nextButton.enabled = !working;
}

- (void)loadFiles {
    [self setWorking:YES];
    [self.restClient loadMetadata:@"/thc-iPad-test" withHash:filesHash];
}

@end
