//
//  SFAppearance.h
//  SFKit
//
//  Created by David Moore on 8/5/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SFKit/SFAppearanceStyle.h>
#import <SFKit/SFAppearanceEnvironment.h>

/**
 Forward declaration.
 */
@protocol SFAppearanceEnvironment;

NS_ASSUME_NONNULL_BEGIN

/**
 San Fransisco is built upon a given set of guiding design principles. Such concepts are bound to change from time-to-time, thereby constituting the `SFAppearance` object.
 The design of San Fransisco objects have been designed to all incorporate a unified look and feel. `SFAppearance` is the only supported method of customization on a global scale.
 */
@interface SFAppearance : NSObject

#pragma mark - Static Properties

/**
 Global San Fransisco appearance.
 */
+ (SFAppearance *)globalAppearance NS_REFINED_FOR_SWIFT;

#pragma mark - Properties

/**
 Style of appearance in this object.
 */
@property (nonatomic) SFAppearanceStyle appearanceStyle DEPRECATED_MSG_ATTRIBUTE("use 'style' instead");

/**
 Style of the appearance as contained by the receiver.
 */
@property (nonatomic) SFAppearanceStyle style;

/**
 Ubiquitous key value store is used to synchronize appearance across multiple devices, and to persist state on a single device.
 */
@property (nonatomic, retain) NSUbiquitousKeyValueStore *_Nullable keyValueStore;

/**
 Boolean value detailing if the appearance style is light.
 */
@property (readonly, getter=isLightAppearanceStyle) BOOL isLightAppearanceStyle DEPRECATED_ATTRIBUTE;

/**
  Determines the most probable status bar style for the current appearance style.
 */
@property (readonly, getter=preferredStatusBarStyle) UIStatusBarStyle preferredStatusBarStyle DEPRECATED_ATTRIBUTE;

#pragma mark - Initialization

/**
 Creates a new `SFAppearance` object with a given style of appearance.
 
 @param appearanceStyle The appearance style for the new `SFAppearance` object.
 */
- (instancetype)initWithAppearanceStyle:(SFAppearanceStyle)appearanceStyle DEPRECATED_MSG_ATTRIBUTE("use 'initWithStyle:' instead");

/**
 Creates a new `SFAppearance` object with a given appearance style.
 
 @param style The appearance style for the new `SFAppearance` object.
 */
- (instancetype)initWithStyle:(SFAppearanceStyle)style;

#pragma mark - Appearance Environment Management

/**
 Appends the appearance environment to the weakly referencing hash table.
 */
- (void)addAppearanceEnvironment:(id <SFAppearanceEnvironment>)appearanceEnvironment;

/**
 Removes the appearance environment-complying object from the hash table and subsequently stops further updates from taking place.
 */
- (void)removeAppearanceEnvironment:(id <SFAppearanceEnvironment>)appearanceEnvironment;

@end

NS_ASSUME_NONNULL_END
