//
//  UIResponder+SFAppearanceEnvironment.h
//  SFKit
//
//  Created by David Moore on 8/5/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SFKit/SFAppearanceEnvironment.h>

@protocol SFAppearanceEnvironment;

@interface UIResponder (SFAppearanceEnvironment) <SFAppearanceEnvironment>

/**
 Register for updates regarding appearance style changes.
 
 @note 'registerForAppearanceUpdates' must be called at least once in order to receive callbacks.
 */
- (void)registerForAppearanceUpdates;

/**
 Unregister for updates regarding appearance changes.
 
 @note 'unregisterForAppearanceUpdates' does not need to be called, nor is it even very useful. Certain instances may benefits performance-wise from calling this method, but 'SFAppearanceEnvironment' is inherently well-designed, as to prevent leaks.
 */
- (void)unregisterForAppearanceUpdates;

@end
