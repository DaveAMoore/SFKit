//
//  UIViewController+SFAppearanceEnvironment.m
//  SFKit
//
//  Created by David Moore on 8/6/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

#import "UIViewController+SFAppearanceEnvironment.h"
#import <SFKit/SFKit.h>

@implementation UIViewController (SFAppearanceEnvironment)

- (void)appearanceStyleDidChange:(SFAppearanceStyle)newAppearanceStyle {
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [SFAppearance globalAppearance].preferredStatusBarStyle;
}

@end
