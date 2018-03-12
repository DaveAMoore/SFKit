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

@implementation UIResponder (SFAppearanceEnvironment)
@dynamic appearance;

#pragma mark - Properties

- (SFAppearance *)appearance {
    SFAppearance *associatedAppearance = (SFAppearance *)objc_getAssociatedObject(self, @selector(appearance));
    if (!associatedAppearance) {
        return [SFAppearance globalAppearance];
    }
    return associatedAppearance;
}

- (void)setAppearance:(SFAppearance *)appearance {
    objc_setAssociatedObject(self, @selector(appearance), appearance, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - Default Implementation

- (void)appearanceStyleDidChange:(SFAppearanceStyle)previousAppearanceStyle {}

- (void)registerForAppearanceUpdates {
    if (![self appearance]) {
        // Create a default appearance.
        SFAppearance *defaultAppearance = [SFAppearance globalAppearance];
        [defaultAppearance addAppearanceEnvironment:self];
        [self setAppearance:defaultAppearance];
    } else {
        [[self appearance] addAppearanceEnvironment:self];
    }
}

- (void)unregisterForAppearanceUpdates {
    if ([self appearance]) {
        // Remove ourselves from the appearance's environment hash table.
        [[self appearance] removeAppearanceEnvironment:self];
    }
}

@end
