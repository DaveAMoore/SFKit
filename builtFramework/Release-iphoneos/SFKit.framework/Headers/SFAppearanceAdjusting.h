//
//  SFAppearanceEnvironmentAdjusting.h
//  SFKit
//
//  Created by David Moore on 3/10/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SFKit/SFAppearanceStyle.h>
#import <SFKit/SFAppearanceEnvironment.h>
#import <SFKit/SFAppearance.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Adopted by environments which desire calls for changes in appearance style.
 */
@protocol SFAppearanceAdjusting <NSObject, SFAppearanceEnvironment>

/**
 Boolean value indicating if the receiver should adjust its color for the current appearance style.
 */
@property (readwrite) BOOL adjustsColorForAppearanceStyle;

@end

NS_ASSUME_NONNULL_END
