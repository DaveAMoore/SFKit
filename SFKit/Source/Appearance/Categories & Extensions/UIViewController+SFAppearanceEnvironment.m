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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
#warning overriding initial '-viewDidLoad' method body can be potentially catastrophic.
- (void)viewDidLoad {
    [self registerForAppearanceUpdates];
}
#pragma clang diagnostic pop

- (void)appearanceStyleDidChange:(SFAppearanceStyle)newAppearanceStyle {
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [SFAppearance globalAppearance].preferredStatusBarStyle;
}

@end
