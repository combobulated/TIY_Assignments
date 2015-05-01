//
//  KitchenSinkTests.m
//  KitchenSinkTests
//
//  Created by Jim on 4/22/15.
//  Copyright (c) 2015 JMD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TIYAddition.h"

@interface KitchenSinkTests : XCTestCase
// Jim, add this method to test our code that has yet tobe made
{
    TIYAddition *addition;
}
@end

@implementation KitchenSinkTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    
    // jim, add
    addition = [[TIYAddition alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// Jim, add this method to test our code that has yet to be made
- (void)testAdditionClassExists
{
    XCTAssertNotNil(addition,@"TIYAddition class exists.");
}
// test this as well
- (void)testAddTwoPlusTwo
{
    int sum = [addition addNumber:2 withNumber:2];
    XCTAssertEqual(sum, 4, @"Addition of 2 + 2 is 4.");
}
- (void)testAddTwoPlusSeven
{
    int sum = [addition addNumber:2 withNumber:7];
    XCTAssertEqual(sum, 9, @"Addition of 2 + 7 is 9.");
    
}
@end
