//
//  SFAppearance.m
//  SFKit
//
//  Created by David Moore on 8/5/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

#import "SFAppearance.h"

@interface SFAppearance ()

@property (nonatomic, retain) NSHashTable<id <SFAppearanceEnvironment>> *appearanceEnvironments;

@end

@implementation SFAppearance
@synthesize appearanceStyle=_appearanceStyle, isLightAppearanceStyle, preferredStatusBarStyle, appearanceEnvironments;

#pragma mark - Singletons

+ (SFAppearance *)globalAppearance {
    static SFAppearance *globalAppearance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalAppearance =[[SFAppearance alloc] initWithAppearanceStyle:SFAppearanceStyleLight];
    });
    
    return globalAppearance;
}

#pragma mark - Properties

- (SFAppearanceStyle)appearanceStyle {
    return _appearanceStyle;
}

- (void)setAppearanceStyle:(SFAppearanceStyle)appearanceStyle {
    // Change the value.
    _appearanceStyle = appearanceStyle;
    
    // Tell every appearance environment about the change.
    for (id <SFAppearanceEnvironment> environment in [appearanceEnvironments allObjects]) {
        [environment appearanceStyleDidChange:[self appearanceStyle]];
    }
}

- (BOOL)isLightAppearanceStyle {
    return [self appearanceStyle] == SFAppearanceStyleLight;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if ([self isLightAppearanceStyle]) {
        return UIStatusBarStyleDefault;
    } else {
        return UIStatusBarStyleLightContent;
    }
}

#pragma mark - Initialization

/**
 Creates a new `SFAppearance` object with a given style of appearance.

 @param appearanceStyle The appearance style for the new `SFAppearance` object.
 */
- (instancetype)initWithAppearanceStyle:(SFAppearanceStyle)appearanceStyle {
    self = [super init];
    if (self) {
        // Setup the appearance style.
        [self setAppearanceStyle:appearanceStyle];
        
        // Initialize appearance environments.
        [self setAppearanceEnvironments:[NSHashTable weakObjectsHashTable]];
    }
    return self;
}

#pragma mark - Appearance Environment Management

/**
 Appends the appearance environment to the weakly referencing hash table.
 */
- (void)addAppearanceEnvironment:(id <SFAppearanceEnvironment>)appearanceEnvironment {
    [appearanceEnvironments addObject:appearanceEnvironment];
    [appearanceEnvironment appearanceStyleDidChange:[self appearanceStyle]];
}

/**
 Removes the appearance environment-complying object from the hash table and subsequently stops further updates from taking place.
 */
- (void)removeAppearanceEnvironment:(id <SFAppearanceEnvironment>)appearanceEnvironment {
    [appearanceEnvironments removeObject:appearanceEnvironment];
}

#pragma mark - Helper Methods

/**
 Posts a change notification with the appropriate notification name, as determined by the caller.

 @param name `Notification.Name` of the change notification that will be posted.
 @param oldValue Value *A*.
 @param newValue Value *B*.
 @note Value *A* will be compared to value *B*, and if they are different, a change notification will be posted to the default notification center.
 */
- (void)postChangeNotificationWithName:(NSNotificationName)name oldValue:(SFAppearanceStyle)oldValue newValue:(SFAppearanceStyle)newValue {
    // Check if the value changed.
    if (oldValue == newValue)
        return;
    
    // Create a notification for the appearance style changing.
    NSNotification *changeNotification = [[NSNotification alloc] initWithName:name
                                                                       object:self
                                                                     userInfo:nil];
    
    // Post the change notification.
    [[NSNotificationCenter defaultCenter] postNotification:changeNotification];
}

@end
