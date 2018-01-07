/*
 Copyright (c) 2015, Apple Inc. All rights reserved.
 Copyright (c) 2015-2016, Ricardo Sánchez-Sáez.

 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 1.  Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2.  Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation and/or
 other materials provided with the distribution.
 
 3.  Neither the name of the copyright holder(s) nor the names of any contributors
 may be used to endorse or promote products derived from this software without
 specific prior written permission. No license is granted to the trademarks of
 the copyright holders even if such marks are included in this software.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


@import UIKit;
#import "SFHelpers_Private.h"
#import "SFTypes.h"
#import "SFErrors.h"


NS_ASSUME_NONNULL_BEGIN

// Logging
#if ( defined(SF_LOG_LEVEL_NONE) && SF_LOG_LEVEL_NONE )
#  undef SF_LOG_LEVEL_DEBUG
#  undef SF_LOG_LEVEL_WARNING
#  undef SF_LOG_LEVEL_ERROR
#endif

#if ( !defined(SF_LOG_LEVEL_NONE) && !defined(SF_LOG_LEVEL_DEBUG) && !defined(SF_LOG_LEVEL_WARNING) && !defined(SF_LOG_LEVEL_ERROR) )
#  define SF_LOG_LEVEL_WARNING 1
#endif

#define _SF_LogWithLevel(level,fmt,...) NSLog(@"[ResearchKit]["#level"] %s " fmt, __PRETTY_FUNCTION__, ## __VA_ARGS__)

#if ( SF_LOG_LEVEL_DEBUG )
#  define SF_Log_Debug(fmt,...) _SF_LogWithLevel(Debug, fmt, ## __VA_ARGS__)
#else
#  define SF_Log_Debug(...)
#endif

#if ( SF_LOG_LEVEL_DEBUG || SF_LOG_LEVEL_WARNING )
#  define SF_Log_Warning(fmt,...) _SF_LogWithLevel(Warning, fmt, ## __VA_ARGS__)
#else
#  define SF_Log_Warning(...)
#endif

#if ( SF_LOG_LEVEL_DEBUG || SF_LOG_LEVEL_WARNING || SF_LOG_LEVEL_ERROR )
#  define SF_Log_Error(fmt,...) _SF_LogWithLevel(Error, fmt, ## __VA_ARGS__)
#else
#  define SF_Log_Error(...)
#endif


#define SF_NARG(...) SF_NARG_(__VA_ARGS__,SF_RSEQ_N())
#define SF_NARG_(...)  SF_ARG_N(__VA_ARGS__)
#define SF_ARG_N( _1, _2, _3, _4, _5, _6, _7, _8, _9,_10, N, ...) N
#define SF_RSEQ_N()   10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0

#define SF_DECODE_OBJ(d,x)  _ ## x = [d decodeObjectForKey:@SF_STRINGIFY(x)]
#define SF_ENCODE_OBJ(c,x)  [c encodeObject:_ ## x forKey:@SF_STRINGIFY(x)]
#define SF_ENCODE_URL(c,x)  [c encodeObject:SFRelativePathForURL(_ ## x) forKey:@SF_STRINGIFY(x)]
#define SF_ENCODE_URL_BOOKMARK(c, x) [c encodeObject:SFBookmarkDataFromURL(_ ## x) forKey:@SF_STRINGIFY(x)]

#define SF_DECODE_OBJ_CLASS(d,x,cl)  _ ## x = (cl *)[d decodeObjectOfClass:[cl class] forKey:@SF_STRINGIFY(x)]
#define SF_DECODE_OBJ_ARRAY(d,x,cl)  _ ## x = (NSArray *)[d decodeObjectOfClasses:[NSSet setWithObjects:[NSArray class],[cl class],nil] forKey:@SF_STRINGIFY(x)]
#define SF_DECODE_OBJ_MUTABLE_ORDERED_SET(d,x,cl)  _ ## x = [(NSOrderedSet *)[d decodeObjectOfClasses:[NSSet setWithObjects:[NSOrderedSet class],[cl class],nil] forKey:@SF_STRINGIFY(x)] mutableCopy]
#define SF_DECODE_OBJ_MUTABLE_DICTIONARY(d,x,kcl,cl)  _ ## x = [(NSDictionary *)[d decodeObjectOfClasses:[NSSet setWithObjects:[NSDictionary class],[kcl class],[cl class],nil] forKey:@SF_STRINGIFY(x)] mutableCopy]

#define SF_ENCODE_COND_OBJ(c,x)  [c encodeConditionalObject:_ ## x forKey:@SF_STRINGIFY(x)]

#define SF_DECODE_IMAGE(d,x)  _ ## x = (UIImage *)[d decodeObjectOfClass:[UIImage class] forKey:@SF_STRINGIFY(x)]
#define SF_ENCODE_IMAGE(c,x)  { if (_ ## x) { UIImage * orkTemp_ ## x = [UIImage imageWithCGImage:[_ ## x CGImage] scale:[_ ## x scale] orientation:[_ ## x imageOrientation]]; [c encodeObject:orkTemp_ ## x forKey:@SF_STRINGIFY(x)]; } }

#define SF_DECODE_URL(d,x)  _ ## x = SFURLForRelativePath((NSString *)[d decodeObjectOfClass:[NSString class] forKey:@SF_STRINGIFY(x)])
#define SF_DECODE_URL_BOOKMARK(d,x)  _ ## x = SFURLFromBookmarkData((NSData *)[d decodeObjectOfClass:[NSData class] forKey:@SF_STRINGIFY(x)])

#define SF_DECODE_BOOL(d,x)  _ ## x = [d decodeBoolForKey:@SF_STRINGIFY(x)]
#define SF_ENCODE_BOOL(c,x)  [c encodeBool:_ ## x forKey:@SF_STRINGIFY(x)]

#define SF_DECODE_DOUBLE(d,x)  _ ## x = [d decodeDoubleForKey:@SF_STRINGIFY(x)]
#define SF_ENCODE_DOUBLE(c,x)  [c encodeDouble:_ ## x forKey:@SF_STRINGIFY(x)]

#define SF_DECODE_INTEGER(d,x)  _ ## x = [d decodeIntegerForKey:@SF_STRINGIFY(x)]
#define SF_ENCODE_INTEGER(c,x)  [c encodeInteger:_ ## x forKey:@SF_STRINGIFY(x)]

#define SF_ENCODE_UINT32(c,x)  [c encodeObject:[NSNumber numberWithUnsignedLongLong:_ ## x] forKey:@SF_STRINGIFY(x)]
#define SF_DECODE_UINT32(d,x)  _ ## x = (uint32_t)[(NSNumber *)[d decodeObjectForKey:@SF_STRINGIFY(x)] unsignedLongValue]

#define SF_DECODE_ENUM(d,x)  _ ## x = [d decodeIntegerForKey:@SF_STRINGIFY(x)]
#define SF_ENCODE_ENUM(c,x)  [c encodeInteger:(NSInteger)_ ## x forKey:@SF_STRINGIFY(x)]

#define SF_DECODE_CGRECT(d,x)  _ ## x = [d decodeCGRectForKey:@SF_STRINGIFY(x)]
#define SF_ENCODE_CGRECT(c,x)  [c encodeCGRect:_ ## x forKey:@SF_STRINGIFY(x)]

#define SF_DECODE_CGSIZE(d,x)  _ ## x = [d decodeCGSizeForKey:@SF_STRINGIFY(x)]
#define SF_ENCODE_CGSIZE(c,x)  [c encodeCGSize:_ ## x forKey:@SF_STRINGIFY(x)]

#define SF_DECODE_CGPOINT(d,x)  _ ## x = [d decodeCGPointForKey:@SF_STRINGIFY(x)]
#define SF_ENCODE_CGPOINT(c,x)  [c encodeCGPoint:_ ## x forKey:@SF_STRINGIFY(x)]

#define SF_DECODE_UIEDGEINSETS(d,x)  _ ## x = [d decodeUIEdgeInsetsForKey:@SF_STRINGIFY(x)]
#define SF_ENCODE_UIEDGEINSETS(c,x)  [c encodeUIEdgeInsets:_ ## x forKey:@SF_STRINGIFY(x)]

#define SF_DECODE_COORDINATE(d,x)  _ ## x = CLLocationCoordinate2DMake([d decodeDoubleForKey:@SF_STRINGIFY(x.latitude)],[d decodeDoubleForKey:@SF_STRINGIFY(x.longitude)])
#define SF_ENCODE_COORDINATE(c,x)  [c encodeDouble:_ ## x.latitude forKey:@SF_STRINGIFY(x.latitude)];[c encodeDouble:_ ## x.longitude forKey:@SF_STRINGIFY(x.longitude)];

/*
 * Helpers for completions which call the block only if non-nil
 *
 */
#define SF_BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };

#define SF_DISPATCH_EXEC(queue, block, ...) if (block) { dispatch_async(queue, ^{ block(__VA_ARGS__); } ); }

/*
 * For testing background delivery
 *
 */
#if SF_BACKGROUND_DELIVERY_TEST
#  define SF_HEALTH_UPDATE_FREQUENCY HKUpdateFrequencyImmediate
#else
#  define SF_HEALTH_UPDATE_FREQUENCY HKUpdateFrequencyDaily
#endif

// Find the first object of the specified class, using method as the iterator
#define SFFirstObjectOfClass(C,p,method) ({ id v = p; while (v != nil) { if ([v isKindOfClass:[C class]]) { break; } else { v = [v method]; } }; v; })

#define SFStrongTypeOf(x) __strong __typeof(x)
#define SFWeakTypeOf(x) __weak __typeof(x)

// Bundle for video assets
NSBundle *SFAssetsBundle(void);
NSBundle *SFBundle(void);
NSBundle *SFDefaultLocaleBundle(void);

// Pass 0xcccccc and get color #cccccc
UIColor *SFRGB(uint32_t x);
UIColor *SFRGBA(uint32_t x, CGFloat alpha);

id findInArrayByKey(NSArray * array, NSString *key, id value);

NSString *SFSignatureStringFromDate(NSDate *date);

NSURL *SFCreateRandomBaseURL(void);

// Marked extern so it is accessible to unit tests
//SF_EXTERN NSString *SFFileProtectionFromMode(SFFileProtectionMode mode);

CGFloat SFExpectedLabelHeight(UILabel *label);
void SFAdjustHeightForLabel(UILabel *label);

// build a image with color
UIImage *SFImageWithColor(UIColor *color);

void SFEnableAutoLayoutForViews(NSArray *views);

NSDateComponentsFormatter *SFTimeIntervalLabelFormatter(void);
NSDateComponentsFormatter *SFDurationStringFormatter(void);

NSDateFormatter *SFTimeOfDayLabelFormatter(void);
NSCalendar *SFTimeOfDayReferenceCalendar(void);

NSDateComponents *SFTimeOfDayComponentsFromDate(NSDate *date);
NSDate *SFTimeOfDayDateFromComponents(NSDateComponents *dateComponents);

BOOL SFCurrentLocalePresentsFamilyNameFirst(void);

UIFont *SFTimeFontForSize(CGFloat size);
UIFontDescriptor *SFFontDescriptorForLightStylisticAlternative(UIFontDescriptor *descriptor);

CGFloat SFFloorToViewScale(CGFloat value, UIView *view);

SF_INLINE bool
SFEqualObjects(id o1, id o2) {
    return (o1 == o2) || (o1 && o2 && [o1 isEqual:o2]);
}

SF_INLINE BOOL
SFEqualFileURLs(NSURL *url1, NSURL *url2) {
    return SFEqualObjects(url1, url2) || ([url1 isFileURL] && [url2 isFileURL] && [[url1 absoluteString] isEqualToString:[url2 absoluteString]]);
}

SF_INLINE NSMutableOrderedSet *
SFMutableOrderedSetCopyObjects(NSOrderedSet *a) {
    if (!a) {
        return nil;
    }
    NSMutableOrderedSet *b = [NSMutableOrderedSet orderedSetWithCapacity:a.count];
    [a enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [b addObject:[obj copy]];
    }];
    return b;
}

SF_INLINE NSMutableDictionary *
SFMutableDictionaryCopyObjects(NSDictionary *a) {
    if (!a) {
        return nil;
    }
    NSMutableDictionary *b = [NSMutableDictionary dictionaryWithCapacity:a.count];
    [a enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        b[key] = [obj copy];
    }];
    return b;
}

#define SFSuppressPerformSelectorWarning(PerformCall) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
PerformCall; \
_Pragma("clang diagnostic pop") \
} while (0)

UIFont *SFThinFontWithSize(CGFloat size);
UIFont *SFLightFontWithSize(CGFloat size);
UIFont *SFMediumFontWithSize(CGFloat size);

NSURL *SFURLFromBookmarkData(NSData *data);
NSData *SFBookmarkDataFromURL(NSURL *url);

NSString *SFPathRelativeToURL(NSURL *url, NSURL *baseURL);
NSURL *SFURLForRelativePath(NSString *relativePath);
NSString *SFRelativePathForURL(NSURL *url);

id SFDynamicCast_(id x, Class objClass);

#define SFDynamicCast(x, c) ((c *) SFDynamicCast_(x, [c class]))

extern const CGFloat SFScrollToTopAnimationDuration;

SF_INLINE CGFloat
SFCGFloatNearlyEqualToFloat(CGFloat f1, CGFloat f2) {
    const CGFloat SFCGFloatEpsilon = 0.01; // 0.01 should be safe enough when dealing with screen point and pixel values
    return (ABS(f1 - f2) <= SFCGFloatEpsilon);
}

#define SFThrowMethodUnavailableException()  @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"method unavailable" userInfo:nil];
#define SFThrowInvalidArgumentExceptionIfNil(argument)  if (!argument) { @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@#argument" cannot be nil." userInfo:nil]; }

void SFValidateArrayForObjectsOfClass(NSArray *array, Class expectedObjectClass, NSString *exceptionReason);

void SFRemoveConstraintsForRemovedViews(NSMutableArray *constraints, NSArray *removedViews);

extern const double SFDoubleInvalidValue;

extern const CGFloat SFCGFloatInvalidValue;

void SFAdjustPageViewControllerNavigationDirectionForRTL(UIPageViewControllerNavigationDirection *direction);

NSString *SFPaddingWithNumberOfSpaces(NSUInteger numberOfPaddingSpaces);

NSNumberFormatter *SFDecimalNumberFormatter(void);

SF_INLINE double SFFeetAndInchesToInches(double feet, double inches) {
    return (feet * 12) + inches;
}

SF_INLINE void SFInchesToFeetAndInches(double inches, double *outFeet, double *outInches) {
    if (outFeet == NULL || outInches == NULL) {
        return;
    }
    *outFeet = floor(inches / 12);
    *outInches = round(fmod(inches, 12));
}

SF_INLINE double SFInchesToCentimeters(double inches) {
    return inches * 2.54;
}

SF_INLINE double SFCentimetersToInches(double centimeters) {
    return centimeters / 2.54;
}

SF_INLINE void SFCentimetersToFeetAndInches(double centimeters, double *outFeet, double *outInches) {
    double inches = SFCentimetersToInches(centimeters);
    SFInchesToFeetAndInches(inches, outFeet, outInches);
}

SF_INLINE double SFFeetAndInchesToCentimeters(double feet, double inches) {
    return SFInchesToCentimeters(SFFeetAndInchesToInches(feet, inches));
}

SF_INLINE void SFKilogramsToWholeAndFraction(double kilograms, double *outWhole, double *outFraction) {
    if (outWhole == NULL || outFraction == NULL) {
        return;
    }
    *outWhole = floor(kilograms);
    *outFraction = round((kilograms - floor(kilograms)) * 100);
}

SF_INLINE void SFKilogramsToPoundsAndOunces(double kilograms, double * _Nullable outPounds, double * _Nullable outOunces) {
    const double SFPoundsPerKilogram = 2.20462262;
    double fractionalPounds = kilograms * SFPoundsPerKilogram;
    double pounds = floor(fractionalPounds);
    double ounces = round((fractionalPounds - pounds) * 16);
    if (ounces == 16) {
        pounds += 1;
        ounces = 0;
    }
    if (outPounds != NULL) {
        *outPounds = pounds;
    }
    if (outOunces != NULL) {
        *outOunces = ounces;
    }
}

SF_INLINE double SFKilogramsToPounds(double kilograms) {
    double pounds;
    SFKilogramsToPoundsAndOunces(kilograms, &pounds, NULL);
    return pounds;
}

SF_INLINE double SFWholeAndFractionToKilograms(double whole, double fraction) {
    double kg = (whole + (fraction / 100));
    return (round(100 * kg) / 100);
}

SF_INLINE double SFPoundsAndOuncesToKilograms(double pounds, double ounces) {
    const double SFKilogramsPerPound = 0.45359237;
    double kg = (pounds + (ounces / 16)) * SFKilogramsPerPound;
    return (round(100 * kg) / 100);
}

SF_INLINE double SFPoundsToKilograms(double pounds) {
    return SFPoundsAndOuncesToKilograms(pounds, 0);
}

SF_INLINE UIColor *SFOpaqueColorWithReducedAlphaFromBaseColor(UIColor *baseColor, NSUInteger colorIndex, NSUInteger totalColors) {
    UIColor *color = baseColor;
    if (totalColors > 1) {
        CGFloat red = 0.0;
        CGFloat green = 0.0;
        CGFloat blue = 0.0;
        CGFloat alpha = 0.0;
        if ([baseColor getRed:&red green:&green blue:&blue alpha:&alpha]) {
            // Avoid a pure transparent color (alpha = 0)
            CGFloat targetAlphaFactor = ((1.0 / totalColors) * colorIndex);
            return [UIColor colorWithRed:red + ((1.0 - red) * targetAlphaFactor)
                                   green:green + ((1.0 - green) * targetAlphaFactor)
                                    blue:blue + ((1.0 - blue) * targetAlphaFactor)
                                   alpha:alpha];
        }
    }
    return color;
}

// Localization
SF_EXTERN NSBundle *SFBundle(void) SF_AVAILABLE_DECL;
SF_EXTERN NSBundle *SFDefaultLocaleBundle(void);

#define SFDefaultLocalizedValue(key) \
[SFDefaultLocaleBundle() localizedStringForKey:key value:@"" table:@"ResearchKit"]

#define SFLocalizedString(key, comment) \
[SFBundle() localizedStringForKey:(key) value:SFDefaultLocalizedValue(key) table:@"ResearchKit"]

#define SFLocalizedStringFromNumber(number) \
[NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterNoStyle]

NS_ASSUME_NONNULL_END
