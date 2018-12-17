//
//  UIViewController+SFAppearanceEnvironment.m
//  SFKit
//
//  Created by David Moore on 8/6/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

#import "UIViewController+SFAppearanceEnvironment.h"
#import <SFKit/SFMethodSwizzler.h>
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
        SFMethodSwizzler *swizzler = [[SFMethodSwizzler alloc] initWithTargetClass:self];
        [swizzler swizzleMethodWithSelector:@selector(appearanceStyleDidChange:)
                      forMethodWithSelector:@selector(_appearanceStyleDidChange:)];
        [swizzler swizzleMethodWithSelector:@selector(viewDidLoad)
                      forMethodWithSelector:@selector(_viewDidLoad)];
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

@end
