//
//	DebugDemoTests.m
//	DebugDemoTests
//
//	Created by Steve Caine on 07/12/14.
//
//	This code is distributed under the terms of the MIT license.
//
//	Copyright (c) 2014 Steve Caine.
//

#import <XCTest/XCTest.h>

@interface DebugDemoTests : XCTestCase

@end

@implementation DebugDemoTests

- (void)setUp {
	[super setUp];
	// Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
}

- (void)testExample {
	XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
