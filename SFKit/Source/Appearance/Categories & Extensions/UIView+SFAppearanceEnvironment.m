//
//  UIView+SFAppearanceEnvironment.m
//  SFKit
//
//  Created by David Moore on 3/10/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

#import "UIView+SFAppearanceEnvironment.h"
#import <SFKit/SFKit.h>
#import <objc/runtime.h>

@implementation UIView (SFAppearanceEnvironment)

+ (void)load {
    // Perform the method swizzling.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self _extendsPrepareForInterfaceBuilder];
        [self _extendsWillMoveToSuperview];
    });
}

/// Swizzled '-prepareForInterfaceBuilder' method.
- (void)_prepareForInterfaceBuilder {
    [self registerForAppearanceUpdates];
    [self _prepareForInterfaceBuilder];
}

- (void)_willMoveToSuperview:(nullable UIView *)newSuperview {
    [self registerForAppearanceUpdates];
    [self _willMoveToSuperview:newSuperview];
}

/// Performs method swizzling between '-prepareForInterfaceBuilder' and '-_prepareForInterfaceBuilder'.
+ (void)_extendsPrepareForInterfaceBuilder {
    // Retrieve the '-prepareForInterfaceBuilder' selector and method implementation.
    SEL prepareForInterfaceBuilderSelector = @selector(prepareForInterfaceBuilder);
    Method prepareForInterfaceBuilderMethod = class_getInstanceMethod(self, prepareForInterfaceBuilderSelector);
    IMP prepareForInterfaceBuilderImplementation = method_getImplementation(prepareForInterfaceBuilderMethod);
    
    // Retrieve the '-_prepareForInterfaceBuilder' selector and method implementation.
    SEL _prepareForInterfaceBuilderSelector = @selector(_prepareForInterfaceBuilder);
    Method _prepareForInterfaceBuilderMethod = class_getInstanceMethod(self, _prepareForInterfaceBuilderSelector);
    IMP _prepareForInterfaceBuilderImplementation = method_getImplementation(_prepareForInterfaceBuilderMethod);
    
    // Attempt to add '-prepareForInterfaceBuilder' with the new implementation.
    BOOL methodWasAdded = class_addMethod(self, prepareForInterfaceBuilderSelector, _prepareForInterfaceBuilderImplementation,
                                          method_getTypeEncoding(_prepareForInterfaceBuilderMethod));
    
    if (methodWasAdded) {
        // Update the selector points to the original '-prepareForInterfaceBuilder' method.
        class_replaceMethod(self, _prepareForInterfaceBuilderSelector, prepareForInterfaceBuilderImplementation,
                            method_getTypeEncoding(prepareForInterfaceBuilderMethod));
    } else {
        method_exchangeImplementations(prepareForInterfaceBuilderMethod, _prepareForInterfaceBuilderMethod);
    }
}

+ (void)_extendsWillMoveToSuperview {
    // Retrieve the '-prepareForInterfaceBuilder' selector and method implementation.
    SEL willMoveToSuperviewSelector = @selector(willMoveToSuperview:);
    Method willMoveToSuperviewMethod = class_getInstanceMethod(self, willMoveToSuperviewSelector);
    IMP willMoveToSuperviewImplementation = method_getImplementation(willMoveToSuperviewMethod);
    
    // Retrieve the '-_prepareForInterfaceBuilder' selector and method implementation.
    SEL _willMoveToSuperviewSelector = @selector(_willMoveToSuperview:);
    Method _willMoveToSuperviewMethod = class_getInstanceMethod(self, _willMoveToSuperviewSelector);
    IMP _willMoveToSuperviewImplementation = method_getImplementation(_willMoveToSuperviewMethod);
    
    // Attempt to add '-prepareForInterfaceBuilder' with the new implementation.
    BOOL methodWasAdded = class_addMethod(self, willMoveToSuperviewSelector, _willMoveToSuperviewImplementation,
                                          method_getTypeEncoding(_willMoveToSuperviewMethod));
    
    if (methodWasAdded) {
        // Update the selector points to the original '-prepareForInterfaceBuilder' method.
        class_replaceMethod(self, _willMoveToSuperviewSelector, willMoveToSuperviewImplementation,
                            method_getTypeEncoding(willMoveToSuperviewMethod));
    } else {
        method_exchangeImplementations(willMoveToSuperviewMethod, _willMoveToSuperviewMethod);
    }
}

@end
