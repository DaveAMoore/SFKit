//
//  SFAppearance.m
//  SFKit
//
//  Created by David Moore on 8/5/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

#import "SFAppearance.h"

NSString *const SFAppearanceStyleRawValueKey = @"SFAppearanceStyleRawValue";

@interface SFAppearance ()

@property (retain) NSHashTable<id <SFAppearanceEnvironment>> *appearanceEnvironments;

@end

@implementation SFAppearance
@synthesize style=_style, appearanceStyle, isLightAppearanceStyle, preferredStatusBarStyle, appearanceEnvironments, keyValueStore=_keyValueStore;

#pragma mark - Singletons

+ (SFAppearance *)globalAppearance {
    static SFAppearance *globalAppearance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalAppearance = [[SFAppearance alloc] initWithStyle:SFAppearanceStyleLight];
    });
    
    return globalAppearance;
}

#pragma mark - Accessors

- (SFAppearanceStyle)appearanceStyle {
    return [self style];
}

- (void)setAppearanceStyle:(SFAppearanceStyle)appearanceStyle {
    [self setStyle:appearanceStyle];
}

- (SFAppearanceStyle)style {
    return _style;
}

- (void)setStyle:(SFAppearanceStyle)style {
    // Capture the last appearance style.
    SFAppearanceStyle previousStyle = _style;
    
    // Change the value.
    _style = style;
    
    // Retrieve the key value store and ensure the value is non-nil.
    NSUbiquitousKeyValueStore *keyValueStore = [self keyValueStore];
    if (keyValueStore) {
        // Use the 'setLongLong:forKey:' method.
        [keyValueStore setLongLong:(NSInteger)style forKey:SFAppearanceStyleRawValueKey];
    }
    
    // Tell every appearance environment about this change.
    for (id <SFAppearanceEnvironment> environment in [appearanceEnvironments allObjects]) {
        [environment appearanceStyleDidChange:previousStyle];
    }
}

- (NSUbiquitousKeyValueStore *)keyValueStore {
    return _keyValueStore;
}

- (void)setKeyValueStore:(NSUbiquitousKeyValueStore *)keyValueStore {
    // Remove the observer it the key value store is different.
    if (_keyValueStore != keyValueStore) {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                                      object:_keyValueStore];
    }
    
    // Change the value.
    _keyValueStore = keyValueStore;
    
    // Register for observation of key value store changes.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyValueStoreDidChangeExternally:)
                                                 name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                               object:keyValueStore];
    
    // Explicitly call the appropriate method to trigger an update.
    [self keyValueStoreDidChangeExternally:nil];
}

- (BOOL)isLightAppearanceStyle {
    return self.style == SFAppearanceStyleLight;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if ([self isLightAppearanceStyle]) {
        return UIStatusBarStyleDefault;
    } else {
        return UIStatusBarStyleLightContent;
    }
}

#pragma mark - Initialization

- (instancetype)initWithAppearanceStyle:(SFAppearanceStyle)appearanceStyle {
    self = [self initWithStyle:appearanceStyle];
    return self;
}

- (instancetype)initWithStyle:(SFAppearanceStyle)style {
    self = [super init];
    if (self) {
        // Setup the appearance style.
        [self setStyle:appearanceStyle];
        
        // Initialize appearance environments.
        [self setAppearanceEnvironments:[NSHashTable weakObjectsHashTable]];
    }
    return self;
}

#pragma mark - Deallocation

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Appearance Synchronization

- (void)keyValueStoreDidChangeExternally:(NSNotification *)note {
    // Synchronize the values between memory and disk.
    [self.keyValueStore synchronize];
    
    // Make sure the value exists.
    if (![self.keyValueStore.dictionaryRepresentation.allKeys containsObject:SFAppearanceStyleRawValueKey])
        return;
    
    // Retrieve and cast the raw appearance style value.
    NSInteger rawValue = (NSInteger)[self.keyValueStore longLongForKey:SFAppearanceStyleRawValueKey];
    SFAppearanceStyle style = (SFAppearanceStyle)rawValue;
    
    // Update the style if it has changed.
    if (self.style != style) {
        [self setStyle:style];
    }
}

#pragma mark - Appearance Environment Management

- (void)addAppearanceEnvironment:(id <SFAppearanceEnvironment>)appearanceEnvironment {
    [appearanceEnvironments addObject:appearanceEnvironment];
    [appearanceEnvironment appearanceStyleDidChange:SFAppearanceStyleLight];
}

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
    NSNotification *changeNotification = [[NSNotification alloc] initWithName:name object:self userInfo:nil];
    
    // Post the change notification.
    [[NSNotificationCenter defaultCenter] postNotification:changeNotification];
}

@end
