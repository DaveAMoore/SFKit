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
    return [self __appearance];
}

- (SFAppearance *)__appearance {
    SFAppearance *associatedAppearance = (SFAppearance *)objc_getAssociatedObject(self, @selector(appearance));
    if (!associatedAppearance) {
        return [SFAppearance globalAppearance];
    }
    return associatedAppearance;
}

- (void)setAppearance:(SFAppearance *)appearance {
    objc_setAssociatedObject(self, @selector(appearance), appearance, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)shouldRegisterForAppearanceUpdates {
    return YES;
}

#pragma mark - Default Implementation

- (void)appearanceStyleDidChange:(SFAppearanceStyle)previousAppearanceStyle {}

- (void)registerForAppearanceUpdates {
    if (![self shouldRegisterForAppearanceUpdates])
        return;
    
    // Add ourselves as an appearance environment.
    [[self __appearance] addAppearanceEnvironment:self];
}

- (void)unregisterForAppearanceUpdates {
    if ([self appearance]) {
        // Remove ourselves from the appearance's environment hash table.
        [[self __appearance] removeAppearanceEnvironment:self];
    }
}

@end
