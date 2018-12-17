//
//  SFMethodSwizzlerTests.m
//  SFKitTests
//
//  Created by David Moore on 12/17/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

#import <XCTest/XCTest.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFMethodSwizzler : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 Creates a new swizzler for a target class.
 */
- (instancetype)initWithTargetClass:(Class)targetClass NS_DESIGNATED_INITIALIZER;

/**
 Class for which methods will be swizzled.
 */
@property (strong, nonatomic) Class targetClass;

/**
 Swizzles one method for another. This essentially means that instead of one method being called, another one is called.
 
 @param selectorA The selector of the method that is currently the correct method.
 @param selectorB The selector of the method that will be swapped into the place of selectorA.
 */
- (void)swizzleMethodWithSelector:(SEL)selectorA forMethodWithSelector:(SEL)selectorB;

@end

NS_ASSUME_NONNULL_END

@interface SFMethodSwizzlerTests : XCTestCase

@end

@implementation SFMethodSwizzlerTests

#pragma mark - Lifecycle

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (SEL)methodA {
    return @selector(methodA);
}

- (SEL)methodB {
    return @selector(methodB);
}

#pragma mark - Tests

- (void)testMethodSwizzling {
    XCTAssertEqual([self methodA], @selector(methodA));
    XCTAssertEqual([self methodB], @selector(methodB));
    
    SFMethodSwizzler *swizzler = [[SFMethodSwizzler alloc] initWithTargetClass:[SFMethodSwizzlerTests class]];
    [swizzler swizzleMethodWithSelector:@selector(methodA) forMethodWithSelector:@selector(methodB)];
    
    XCTAssertEqual([self methodA], @selector(methodB));
    XCTAssertEqual([self methodB], @selector(methodA));
}

@end
