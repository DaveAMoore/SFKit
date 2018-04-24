//
//  SFAppearanceEnvironment.h
//  SFKit
//
//  Created by David Moore on 8/5/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SFKit/SFAppearanceStyle.h>
#import <SFKit/SFAppearance.h>

/**
 Forward declaration.
 */
@class SFAppearance;

NS_ASSUME_NONNULL_BEGIN

/**
 Adopted by environments which desire calls for changes in appearance style.
 */
@protocol SFAppearanceEnvironment <NSObject>

/**
 The appearance object which the style changes are concerned with.
 */
@property (retain, readonly) SFAppearance *appearance;

/**
 This method is called whenever the appearance an object is correlated to, changes.
 
 @param previousAppearanceStyle The appearance style before the change occurred.
 
 @warning Method behaviour changed from passing newAppearanceStyle to providing the previousAppearanceStyle.
 */
- (void)appearanceStyleDidChange:(SFAppearanceStyle)previousAppearanceStyle;

/**
 Boolean value indicating if the receiver should continue registering for appearance updates.
 */
- (BOOL)shouldRegisterForAppearanceUpdates;

@end

NS_ASSUME_NONNULL_END
