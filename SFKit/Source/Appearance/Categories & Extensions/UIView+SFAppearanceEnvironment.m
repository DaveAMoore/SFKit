//
//  UIView+SFAppearanceEnvironment.m
//  SFKit
//
//  Created by David Moore on 3/10/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

#import "UIView+SFAppearanceEnvironment.h"
#import <SFKit/SFMethodSwizzler.h>
#import <SFKit/SFKit-Swift.h>
#import <SFKit/SFKit.h>

@implementation UIView (SFAppearanceEnvironment)
@dynamic adjustsColorForAppearanceStyle;

#pragma mark - Properties

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

#pragma mark - Swizzling

+ (void)load {
    // Perform the method swizzling.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SFMethodSwizzler *swizzler = [[SFMethodSwizzler alloc] initWithTargetClass:self];
        [swizzler swizzleMethodWithSelector:@selector(appearanceStyleDidChange:)
                      forMethodWithSelector:@selector(_appearanceStyleDidChange:)];
        [swizzler swizzleMethodWithSelector:@selector(prepareForInterfaceBuilder)
                      forMethodWithSelector:@selector(_prepareForInterfaceBuilder)];
        [swizzler swizzleMethodWithSelector:@selector(willMoveToSuperview:)
                      forMethodWithSelector:@selector(_willMoveToSuperview:)];
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

- (void)_appearanceStyleDidChange:(SFAppearanceStyle)previousAppearanceStyle {
    if ([self adjustsColorForAppearanceStyle])
        [self adjustColorForAppearanceStyle:previousAppearanceStyle];
    [self _appearanceStyleDidChange:previousAppearanceStyle];
}

- (void)adjustColorForAppearanceStyle:(SFAppearanceStyle)previousAppearanceStyle {
    if (!self.backgroundColor)
        return;
    
    UIColorMetrics *previousColorMetrics = [[UIColorMetrics alloc] initForAppearanceStyle:previousAppearanceStyle];
    UIColorMetrics *currentColorMetrics = [[UIColorMetrics alloc] initForAppearance:self.appearance];
    
    UIColorMetricsHue relativeHue = [previousColorMetrics relativeHueForColor:self.backgroundColor];
    [self setBackgroundColor:[currentColorMetrics relativeColorForHue:relativeHue]];
}

@end
