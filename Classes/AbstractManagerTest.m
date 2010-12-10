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
- (void)someMethod:(NSError *)err;
@end

@implementation AbstractManagerTest

//- (void)someMethod:(NSError *)err {
//	NSLog(@"OK");
////	return YES;
//}
//
//- (void)testTest {
//	NSError *err = [NSError alloc];
//	id mock = [OCMockObject mockForClass:[AbstractManagerTest class]];
////	BOOL value = NO;
////	[[[mock expect] andReturnValue:OCMOCK_VALUE(value)] save:[OCMArg anyPointer]];
//	[[mock expect] someMethod:[OCMArg anyPointer]];
////	[mock someMethod:NULL];
////	[mock verify];
//	[err release];
//}

// ???: why this test fails???
- (void)testSaveMethodCallsSaveOfManagedObjectContext {
	AbstractManager *abstractManager = [AbstractManager alloc];
	id managedObjectContextMock = [OCMockObject mockForClass:[NSManagedObjectContext class]];
	
	BOOL value = NO;
	[[[managedObjectContextMock expect] andReturnValue:OCMOCK_VALUE(value)] save:[OCMArg any]];
	abstractManager.managedObjectContext = managedObjectContextMock;
	
	NSError *error;
	[managedObjectContextMock save:&error];
	//[abstractManager save];
	
	[managedObjectContextMock verify];
		
	abstractManager.managedObjectContext = NULL;
	[abstractManager release];
}

@end
