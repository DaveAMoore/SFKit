//
//  UIViewController+SFAppearanceEnvironment.m
//  SFKit
//
//  Created by David Moore on 8/6/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

#import "UIViewController+SFAppearanceEnvironment.h"
#import <SFKit/SFKit.h>
#import <objc/runtime.h>

@implementation UIViewController (SFAppearanceEnvironment)
@dynamic adjustsColorForAppearanceStyle;

// MARK: - Properties

- (BOOL)adjustsColorForAppearanceStyle {
    NSNumber *associatedValue = objc_getAssociatedObject(self, @selector(adjustsColorForAppearanceStyle));
    if (!associatedValue) {
        return YES;
    }
    return [associatedValue boolValue];
}

- (void)setAdjustsColorForAppearanceStyle:(BOOL)adjustsColorForAppearanceStyle {
    NSNumber *associatedValue = [NSNumber numberWithBool:adjustsColorForAppearanceStyle];
    objc_setAssociatedObject(self, @selector(adjustsColorForAppearanceStyle),
                             associatedValue, OBJC_ASSOCIATION_RETAIN);
}

// MARK: - Swizzling

+ (void)load {
    // Perform the method swizzling.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self _extendsAppearanceStyleDidChange];
        [self _extendsViewDidLoad];
    });
}

/// Swizzled '-viewDidLoad' method.
- (void)_viewDidLoad {
    if ([self shouldRegisterForAppearanceUpdates]) {
        [self registerForAppearanceUpdates];
    }
    [self _viewDidLoad];
}

/// Swizzled '-appearanceStyleDidChange:' method.
- (void)_appearanceStyleDidChange:(SFAppearanceStyle)previousAppearanceStyle {
    if ([self adjustsColorForAppearanceStyle])
        [self adjustColorForAppearanceStyle];
    [self _appearanceStyleDidChange:previousAppearanceStyle];
}

- (void)adjustColorForAppearanceStyle {
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.appearance.style == SFAppearanceStyleLight) {
        return UIStatusBarStyleDefault;
    } else {
        return UIStatusBarStyleLightContent;
    }
}

/// Preforms method swizzling between '-viewDidLoad' and '-_viewDidLoad'.
+ (void)_extendsViewDidLoad {
    // Retrieve the '-viewDidLoad' selector and method implementation.
    SEL viewDidLoadSelector = @selector(viewDidLoad);
    Method viewDidLoadMethod = class_getInstanceMethod(self, viewDidLoadSelector);
    IMP viewDidLoadImplementation = method_getImplementation(viewDidLoadMethod);
    
    // Retrieve the '-_viewDidLoad' selector and method implementation.
    SEL _viewDidLoadSelector = @selector(_viewDidLoad);
    Method _viewDidLoadMethod = class_getInstanceMethod(self, _viewDidLoadSelector);
    IMP _viewDidLoadImplementation = method_getImplementation(_viewDidLoadMethod);
    
    // Attempt to add '-viewDidLoad' with the new implementation.
    BOOL methodWasAdded = class_addMethod(self, viewDidLoadSelector, _viewDidLoadImplementation,
                                          method_getTypeEncoding(_viewDidLoadMethod));
    
    if (methodWasAdded) {
        // Update the selector points to the original '-viewDidLoad' method.
        class_replaceMethod(self, _viewDidLoadSelector, viewDidLoadImplementation,
                            method_getTypeEncoding(viewDidLoadMethod));
    } else {
        method_exchangeImplementations(viewDidLoadMethod, _viewDidLoadMethod);
    }
}

+ (void)_extendsAppearanceStyleDidChange {
    // Retrieve the '-prepareForInterfaceBuilder' selector and method implementation.
    SEL appearanceStyleDidChangeSelector = @selector(appearanceStyleDidChange:);
    Method appearanceStyleDidChangeMethod = class_getInstanceMethod(self, appearanceStyleDidChangeSelector);
    IMP appearanceStyleDidChangeImplementation = method_getImplementation(appearanceStyleDidChangeMethod);
    
    // Retrieve the '-_prepareForInterfaceBuilder' selector and method implementation.
    SEL _appearanceStyleDidChangeSelector = @selector(_appearanceStyleDidChange:);
    Method _appearanceStyleDidChangeMethod = class_getInstanceMethod(self, _appearanceStyleDidChangeSelector);
    IMP _appearanceStyleDidChangeImplementation = method_getImplementation(_appearanceStyleDidChangeMethod);
    
    // Attempt to add '-prepareForInterfaceBuilder' with the new implementation.
    BOOL methodWasAdded = class_addMethod(self, appearanceStyleDidChangeSelector, _appearanceStyleDidChangeImplementation,
                                          method_getTypeEncoding(_appearanceStyleDidChangeMethod));
    
    if (methodWasAdded) {
        // Update the selector points to the original '-appearanceStyleDidChange' method.
        class_replaceMethod(self, _appearanceStyleDidChangeSelector, appearanceStyleDidChangeImplementation,
                            method_getTypeEncoding(appearanceStyleDidChangeMethod));
    } else {
        method_exchangeImplementations(appearanceStyleDidChangeMethod, _appearanceStyleDidChangeMethod);
    }
}

@end
