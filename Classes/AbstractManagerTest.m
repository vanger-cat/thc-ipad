//
//  AbstractManagerTest.m
//  thc-ipad
//
//  Created by Vanger on 05.12.10.
//  Copyright 2010 Magic Ink. All rights reserved.
//

#import "GTMSenTestCase.h"
#import <OCMock/OCMock.h>
#import <CoreData/CoreData.h>

#import "AbstractManager.h"



@interface AbstractManagerTest : GTMTestCase {
}
@end

@implementation AbstractManagerTest

- (void)testSaveMethodCallsSaveOfManagedObjectContext {
	AbstractManager *abstractManager = [AbstractManager alloc];
	id managedObjectContextMock = [OCMockObject mockForClass:[NSManagedObjectContext class]];
	
	BOOL value = NO;
	[[[managedObjectContextMock expect] andReturnValue:OCMOCK_VALUE(value)] save:[OCMArg anyPointer]];
	abstractManager.managedObjectContext = managedObjectContextMock;
	
	[abstractManager save];
	
	[managedObjectContextMock verify];
		
	abstractManager.managedObjectContext = NULL;
	[abstractManager release];
}

@end
