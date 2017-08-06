//
//  UIResponder+SFAppearanceEnvironment.m
//  SFKit
//
//  Created by David Moore on 8/5/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

#import "UIResponder+SFAppearanceEnvironment.h"
#import <SFKit/SFAppearanceEnvironment.h>
#import <SFKit/SFKit-Swift.h>
#import <objc/runtime.h>

/**
 Key which the `appearance` is stored under 'objc_getAssociatedObject' as.
 */
static char kSFAppearanceEnvironmentAppearance;

@implementation UIResponder (SFAppearanceEnvironment)
@dynamic appearance;

#pragma mark - Properties

- (SFAppearance *)appearance {
    SFAppearance *associatedAppearance = (SFAppearance *)objc_getAssociatedObject(self, &kSFAppearanceEnvironmentAppearance);
    return associatedAppearance;
}

- (void)setAppearance:(SFAppearance *)appearance {
    objc_setAssociatedObject(self, &kSFAppearanceEnvironmentAppearance, appearance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark: - Default Implementation

- (void)appearanceStyleDidChange:(SFAppearanceStyle)newAppearanceStyle {}

- (void)registerForAppearanceUpdates {
    if (![self appearance]) {
        // Create a default appearance.
        SFAppearance *defaultAppearance = [SFAppearance globalAppearance];
        [defaultAppearance addAppearanceEnvironment:self];
        [self setAppearance:defaultAppearance];
    }
}

- (void)unregisterForAppearanceUpdates {
    if ([self appearance]) {
        // Remove ourselves from the appearance's environment hash table.
        [[self appearance] removeAppearanceEnvironment:self];
    }
}

@end
