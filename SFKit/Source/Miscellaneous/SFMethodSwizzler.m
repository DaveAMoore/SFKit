//
//  SFMethodSwizzler.m
//  SFKit
//
//  Created by David Moore on 12/17/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

#import "SFMethodSwizzler.h"
#import <objc/runtime.h>

@implementation SFMethodSwizzler
@synthesize targetClass;

- (instancetype)initWithTargetClass:(Class)targetClass {
    self = [super init];
    if (self) {
        self.targetClass = targetClass;
    }
    return self;
}

- (void)swizzleMethodWithSelector:(SEL)selectorA forMethodWithSelector:(SEL)selectorB {
    // A - Retrieve the selector and method implementation.
    Method methodA = class_getInstanceMethod(targetClass, selectorA);
    IMP implementationA = method_getImplementation(methodA);
    
    // B - Retrieve the selector and method implementation.
    Method methodB = class_getInstanceMethod(targetClass, selectorB);
    IMP implementationB = method_getImplementation(methodB);
    
    // Attempt to add methodB with the new implementation.
    BOOL methodWasAdded = class_addMethod(targetClass, selectorA, implementationB,
                                          method_getTypeEncoding(methodB));
    
    if (methodWasAdded) {
        // Update the selector points to the original '-appearanceStyleDidChange' method.
        class_replaceMethod(targetClass, selectorB, implementationA,
                            method_getTypeEncoding(methodA));
    } else {
        method_exchangeImplementations(methodA, methodB);
    }
}

@end
