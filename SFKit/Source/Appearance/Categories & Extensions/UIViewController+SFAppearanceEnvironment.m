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

+ (void)load {
    // Perform the method swizzling.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self _extendsViewDidLoad];
    });
}

/// Swizzled '-viewDidLoad' method.
- (void)_viewDidLoad {
    [self registerForAppearanceUpdates];
    [self _viewDidLoad];
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

- (void)appearanceStyleDidChange:(SFAppearanceStyle)newAppearanceStyle {
    [super appearanceStyleDidChange:newAppearanceStyle];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if ([[SFAppearance globalAppearance] style] == SFAppearanceStyleLight) {
        return UIStatusBarStyleDefault;
    } else {
        return UIStatusBarStyleLightContent;
    }
}

@end
