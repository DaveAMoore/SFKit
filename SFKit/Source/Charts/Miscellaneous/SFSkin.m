/*
 Copyright (c) 2015, Apple Inc. All rights reserved.
 
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


#import "SFSkin.h"

#import "SFHelpers_Internal.h"


NSString *const SFSignatureColorKey = @"SFSignatureColorKey";
NSString *const SFBackgroundColorKey = @"SFBackgroundColorKey";
NSString *const SFToolBarTintColorKey = @"SFToolBarTintColorKey";
NSString *const SFLightTintColorKey = @"SFLightTintColorKey";
NSString *const SFDarkTintColorKey = @"SFDarkTintColorKey";
NSString *const SFCaptionTextColorKey = @"SFCaptionTextColorKey";
NSString *const SFBlueHighlightColorKey = @"SFBlueHighlightColorKey";
NSString *const SFChartDefaultTextColorKey = @"SFChartDefaultTextColorKey";
NSString *const SFGraphAxisColorKey = @"SFGraphAxisColorKey";
NSString *const SFGraphAxisTitleColorKey = @"SFGraphAxisTitleColorKey";
NSString *const SFGraphReferenceLineColorKey = @"SFGraphReferenceLineColorKey";
NSString *const SFGraphScrubberLineColorKey = @"SFGraphScrubberLineColorKey";
NSString *const SFGraphScrubberThumbColorKey = @"SFGraphScrubberThumbColorKey";
NSString *const SFAuxiliaryImageTintColorKey = @"SFAuxiliaryImageTintColorKey";

@implementation UIColor (SFColor)

#define SFCachedColorMethod(m, r, g, b, a) \
+ (UIColor *)m { \
    static UIColor *c##m = nil; \
    static dispatch_once_t onceToken##m; \
    dispatch_once(&onceToken##m, ^{ \
        c##m = [[UIColor alloc] initWithRed:r green:g blue:b alpha:a]; \
    }); \
    return c##m; \
}

SFCachedColorMethod(ork_midGrayTintColor, 0.0 / 255.0, 0.0 / 255.0, 25.0 / 255.0, 0.22)
SFCachedColorMethod(ork_redColor, 255.0 / 255.0,  59.0 / 255.0,  48.0 / 255.0, 1.0)
SFCachedColorMethod(ork_grayColor, 142.0 / 255.0, 142.0 / 255.0, 147.0 / 255.0, 1.0)
SFCachedColorMethod(ork_darkGrayColor, 102.0 / 255.0, 102.0 / 255.0, 102.0 / 255.0, 1.0)

#undef SFCachedColorMethod

@end

static NSMutableDictionary *colors() {
    static NSMutableDictionary *colors = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colors = [@{
                    SFSignatureColorKey: SFRGB(0x000000),
                    SFBackgroundColorKey: SFRGB(0xffffff),
                    SFToolBarTintColorKey: SFRGB(0xffffff),
                    SFLightTintColorKey: SFRGB(0xeeeeee),
                    SFDarkTintColorKey: SFRGB(0x888888),
                    SFCaptionTextColorKey: SFRGB(0xcccccc),
                    SFBlueHighlightColorKey: [UIColor colorWithRed:0.0 green:122.0 / 255.0 blue:1.0 alpha:1.0],
                    SFChartDefaultTextColorKey: [UIColor lightGrayColor],
                    SFGraphAxisColorKey: [UIColor colorWithRed:217.0 / 255.0 green:217.0 / 255.0 blue:217.0 / 255.0 alpha:1.0],
                    SFGraphAxisTitleColorKey: [UIColor colorWithRed:142.0 / 255.0 green:142.0 / 255.0 blue:147.0 / 255.0 alpha:1.0],
                    SFGraphReferenceLineColorKey: [UIColor colorWithRed:225.0 / 255.0 green:225.0 / 255.0 blue:229.0 / 255.0 alpha:1.0],
                    SFGraphScrubberLineColorKey: [UIColor grayColor],
                    SFGraphScrubberThumbColorKey: [UIColor colorWithWhite:1.0 alpha:1.0],
                    SFAuxiliaryImageTintColorKey: [UIColor colorWithRed:228.0 / 255.0 green:233.0 / 255.0 blue:235.0 / 255.0 alpha:1.0],
                    } mutableCopy];
    });
    return colors;
}

UIColor *SFColor(NSString *colorKey) {
    return colors()[colorKey];
}

void SFColorSetColorForKey(NSString *key, UIColor *color) {
    NSMutableDictionary *d = colors();
    d[key] = color;
}

const CGSize SFiPhone4ScreenSize = (CGSize){320, 480};
const CGSize SFiPhone5ScreenSize = (CGSize){320, 568};
const CGSize SFiPhone6ScreenSize = (CGSize){375, 667};
const CGSize SFiPhone6PlusScreenSize = (CGSize){414, 736};
const CGSize SFiPadScreenSize = (CGSize){768, 1024};
const CGSize SFiPad12_9ScreenSize = (CGSize){1024, 1366};

SFScreenType SFGetVerticalScreenTypeForBounds(CGRect bounds) {
    SFScreenType screenType = SFScreenTypeiPhone6;
    CGFloat maximumDimension = MAX(bounds.size.width, bounds.size.height);
    if (maximumDimension < SFiPhone4ScreenSize.height + 1) {
        screenType = SFScreenTypeiPhone4;
    } else if (maximumDimension < SFiPhone5ScreenSize.height + 1) {
        screenType = SFScreenTypeiPhone5;
    } else if (maximumDimension < SFiPhone6ScreenSize.height + 1) {
        screenType = SFScreenTypeiPhone6;
    } else if (maximumDimension < SFiPhone6PlusScreenSize.height + 1) {
        screenType = SFScreenTypeiPhone6Plus;
    } else if (maximumDimension < SFiPadScreenSize.height + 1) {
        screenType = SFScreenTypeiPad;
    } else {
        screenType = SFScreenTypeiPad12_9;
    }
    return screenType;
}

SFScreenType SFGetHorizontalScreenTypeForBounds(CGRect bounds) {
    SFScreenType screenType = SFScreenTypeiPhone6;
    CGFloat minimumDimension = MIN(bounds.size.width, bounds.size.height);
    if (minimumDimension < SFiPhone4ScreenSize.width + 1) {
        screenType = SFScreenTypeiPhone4;
    } else if (minimumDimension < SFiPhone5ScreenSize.width + 1) {
        screenType = SFScreenTypeiPhone5;
    } else if (minimumDimension < SFiPhone6ScreenSize.width + 1) {
        screenType = SFScreenTypeiPhone6;
    } else if (minimumDimension < SFiPhone6PlusScreenSize.width + 1) {
        screenType = SFScreenTypeiPhone6Plus;
    } else if (minimumDimension < SFiPadScreenSize.width + 1) {
        screenType = SFScreenTypeiPad;
    } else {
        screenType = SFScreenTypeiPad12_9;
    }
    return screenType;
}

UIWindow *SFDefaultWindowIfWindowIsNil(UIWindow *window) {
    if (!window) {
        // Use this method instead of UIApplication's keyWindow or UIApplication's delegate's window
        // because we may need the window before the keyWindow is set (e.g., if a view controller
        // loads programmatically on the app delegate to be assigned as the root view controller)
        //window = [UIApplication sharedApplication].windows.firstObject;
    }
    return window;
}

SFScreenType SFGetVerticalScreenTypeForWindow(UIWindow *window) {
    window = SFDefaultWindowIfWindowIsNil(window);
    return SFGetVerticalScreenTypeForBounds(window.bounds);
}

SFScreenType SFGetHorizontalScreenTypeForWindow(UIWindow *window) {
    window = SFDefaultWindowIfWindowIsNil(window);
    return SFGetHorizontalScreenTypeForBounds(window.bounds);
}

SFScreenType SFGetScreenTypeForScreen(UIScreen *screen) {
    SFScreenType screenType = SFScreenTypeiPhone6;
    if (screen == [UIScreen mainScreen]) {
        screenType = SFGetVerticalScreenTypeForBounds(screen.bounds);
    }
    return screenType;
}

const CGFloat SFScreenMetricMaxDimension = 10000.0;

CGFloat SFGetMetricForScreenType(SFScreenMetric metric, SFScreenType screenType) {
    static  const CGFloat metrics[SFScreenMetric_COUNT][SFScreenType_COUNT] = {
        // iPhone 6+,  iPhone 6,  iPhone 5,  iPhone 4,      iPad  iPad 12.9
        {        128,       128,       100,       100,       218,       218},      // SFScreenMetricTopToCaptionBaseline
        {         35,        35,        32,        24,        35,        35},      // SFScreenMetricFontSizeHeadline
        {         38,        38,        32,        28,        38,        38},      // SFScreenMetricMaxFontSizeHeadline
        {         30,        30,        30,        24,        30,        30},      // SFScreenMetricFontSizeSurveyHeadline
        {         32,        32,        32,        28,        32,        32},      // SFScreenMetricMaxFontSizeSurveyHeadline
        {         17,        17,        17,        16,        17,        17},      // SFScreenMetricFontSizeSubheadline
        {         12,        12,        12,        11,        12,        12},      // SFScreenMetricFontSizeFootnote
        {         62,        62,        51,        51,        62,        62},      // SFScreenMetricCaptionBaselineToFitnessTimerTop
        {         62,        62,        43,        43,        62,        62},      // SFScreenMetricCaptionBaselineToTappingLabelTop
        {         36,        36,        32,        32,        36,        36},      // SFScreenMetricCaptionBaselineToInstructionBaseline
        {         30,        30,        28,        24,        30,        30},      // SFScreenMetricInstructionBaselineToLearnMoreBaseline
        {         44,        44,        20,        14,        44,        44},      // SFScreenMetricLearnMoreBaselineToStepViewTop
        {         40,        40,        30,        14,        40,        40},      // SFScreenMetricLearnMoreBaselineToStepViewTopWithNoLearnMore
        {         36,        36,        20,        12,        36,        36},      // SFScreenMetricContinueButtonTopMargin
        {         40,        40,        20,        12,        40,        40},      // SFScreenMetricContinueButtonTopMarginForIntroStep
        {          0,         0,         0,         0,        80,       170},      // SFScreenMetricTopToIllustration
        {         44,        44,        40,        40,        44,        44},      // SFScreenMetricIllustrationToCaptionBaseline
        {        198,       198,       194,       152,       297,       297},      // SFScreenMetricIllustrationHeight
        {        300,       300,       176,       152,       300,       300},      // SFScreenMetricInstructionImageHeight
        {         44,        44,        44,        44,        44,        44},      // SFScreenMetricContinueButtonHeightRegular
        {         44,        32,        32,        32,        44,        44},      // SFScreenMetricContinueButtonHeightCompact
        {        150,       150,       146,       146,       150,       150},      // SFScreenMetricContinueButtonWidth
        {        162,       162,       120,       116,       240,       240},      // SFScreenMetricMinimumStepHeaderHeightForMemoryGame
        {        162,       162,       120,       116,       240,       240},      // SFScreenMetricMinimumStepHeaderHeightForTowerOfHanoiPuzzle
        {         60,        60,        60,        44,        60,        60},      // SFScreenMetricTableCellDefaultHeight
        {         55,        55,        55,        44,        55,        55},      // SFScreenMetricTextFieldCellHeight
        {         36,        36,        36,        26,        36,        36},      // SFScreenMetricChoiceCellFirstBaselineOffsetFromTop,
        {         24,        24,        24,        18,        24,        24},      // SFScreenMetricChoiceCellLastBaselineToBottom,
        {         24,        24,        24,        24,        24,        24},      // SFScreenMetricChoiceCellLabelLastBaselineToLabelFirstBaseline,
        {         30,        30,        20,        20,        30,        30},      // SFScreenMetricLearnMoreButtonSideMargin
        {         10,        10,         0,         0,        10,        10},      // SFScreenMetricHeadlineSideMargin
        {         44,        44,        44,        44,        44,        44},      // SFScreenMetricToolbarHeight
        {        322,       274,       217,       217,       446,       446},      // SFScreenMetricVerticalScaleHeight
        {        208,       208,       208,       198,       256,       256},      // SFScreenMetricSignatureViewHeight
        {        384,       324,       304,       304,       384,       384},      // SFScreenMetricPSATKeyboardViewWidth
        {        197,       167,       157,       157,       197,       197},      // SFScreenMetricPSATKeyboardViewHeight
        {        238,       238,       150,        90,       238,       238},      // SFScreenMetricLocationQuestionMapHeight
        {         40,        40,        20,        14,        40,        40},      // SFScreenMetricTopToIconImageViewTop
        {         44,        44,        40,        40,        80,        80},      // SFScreenMetricIconImageViewToCaptionBaseline
        {         30,        30,        26,        22,        30,        30},      // SFScreenMetricVerificationTextBaselineToResendButtonBaseline
    };
    return metrics[metric][screenType];
}

CGFloat SFGetMetricForWindow(SFScreenMetric metric, UIWindow *window) {
    CGFloat metricValue = 0;
    switch (metric) {
        case SFScreenMetricContinueButtonWidth:
        case SFScreenMetricHeadlineSideMargin:
        case SFScreenMetricLearnMoreButtonSideMargin:
            metricValue = SFGetMetricForScreenType(metric, SFGetHorizontalScreenTypeForWindow(window));
            break;
            
        default:
            metricValue = SFGetMetricForScreenType(metric, SFGetVerticalScreenTypeForWindow(window));
            break;
    }
    
    return metricValue;
}

const CGFloat SFLayoutMarginWidthRegularBezel = 15.0;
const CGFloat SFLayoutMarginWidthThinBezelRegular = 20.0;
const CGFloat SFLayoutMarginWidthiPad = 115.0;

CGFloat SFStandardLeftTableViewCellMarginForWindow(UIWindow *window) {
    CGFloat margin = 0;
    switch (SFGetHorizontalScreenTypeForWindow(window)) {
        case SFScreenTypeiPhone4:
        case SFScreenTypeiPhone5:
        case SFScreenTypeiPhone6:
            margin = SFLayoutMarginWidthRegularBezel;
            break;
        case SFScreenTypeiPhone6Plus:
        case SFScreenTypeiPad:
        case SFScreenTypeiPad12_9:
        default:
            margin = SFLayoutMarginWidthThinBezelRegular;
            break;
    }
    return margin;
}

CGFloat SFStandardLeftMarginForTableViewCell(UITableViewCell *cell) {
    return SFStandardLeftTableViewCellMarginForWindow(cell.window);
}

CGFloat SFStandardHorizontalAdaptiveSizeMarginForiPadWidth(CGFloat screenSizeWidth, UIWindow *window) {
    // Use adaptive side margin, if window is wider than iPhone6 Plus.
    // Min Marign = SFLayoutMarginWidthThinBezelRegular, Max Marign = SFLayoutMarginWidthiPad or iPad12_9
    
    CGFloat ratio =  (window.bounds.size.width - SFiPhone6PlusScreenSize.width) / (screenSizeWidth - SFiPhone6PlusScreenSize.width);
    ratio = MIN(1.0, ratio);
    ratio = MAX(0.0, ratio);
    return SFLayoutMarginWidthThinBezelRegular + (SFLayoutMarginWidthiPad - SFLayoutMarginWidthThinBezelRegular)*ratio;
}

CGFloat SFStandardHorizontalMarginForWindow(UIWindow *window) {
    window = SFDefaultWindowIfWindowIsNil(window); // need a proper window to use bounds
    CGFloat margin = 0;
    switch (SFGetHorizontalScreenTypeForWindow(window)) {
        case SFScreenTypeiPhone4:
        case SFScreenTypeiPhone5:
        case SFScreenTypeiPhone6:
        case SFScreenTypeiPhone6Plus:
        default:
            margin = SFStandardLeftTableViewCellMarginForWindow(window);
            break;
        case SFScreenTypeiPad:{
            margin = SFStandardHorizontalAdaptiveSizeMarginForiPadWidth(SFiPadScreenSize.width, window);
            break;
        }
        case SFScreenTypeiPad12_9:{
            margin = SFStandardHorizontalAdaptiveSizeMarginForiPadWidth(SFiPad12_9ScreenSize.width, window);
            break;
        }
    }
    return margin;
}

CGFloat SFStandardHorizontalMarginForView(UIView *view) {
    return SFStandardHorizontalMarginForWindow(view.window);
}

UIEdgeInsets SFStandardLayoutMarginsForTableViewCell(UITableViewCell *cell) {
    const CGFloat StandardVerticalTableViewCellMargin = 8.0;
    return (UIEdgeInsets){.left = SFStandardLeftMarginForTableViewCell(cell),
                          .right = SFStandardLeftMarginForTableViewCell(cell),
                          .bottom = StandardVerticalTableViewCellMargin,
                          .top = StandardVerticalTableViewCellMargin};
}

UIEdgeInsets SFStandardFullScreenLayoutMarginsForView(UIView *view) {
    UIEdgeInsets layoutMargins = UIEdgeInsetsZero;
    SFScreenType screenType = SFGetHorizontalScreenTypeForWindow(view.window);
    if (screenType == SFScreenTypeiPad || screenType == SFScreenTypeiPad12_9) {
        CGFloat margin = SFStandardHorizontalMarginForView(view);
        layoutMargins = (UIEdgeInsets){.left = margin, .right = margin };
    }
    return layoutMargins;
}

UIEdgeInsets SFScrollIndicatorInsetsForScrollView(UIView *view) {
    UIEdgeInsets scrollIndicatorInsets = UIEdgeInsetsZero;
    SFScreenType screenType = SFGetHorizontalScreenTypeForWindow(view.window);
    if (screenType == SFScreenTypeiPad || screenType == SFScreenTypeiPad12_9) {
        CGFloat margin = SFStandardHorizontalMarginForView(view);
        scrollIndicatorInsets = (UIEdgeInsets){.left = -margin, .right = -margin };
    }
    return scrollIndicatorInsets;
}

CGFloat SFWidthForSignatureView(UIWindow *window) {
    window = SFDefaultWindowIfWindowIsNil(window); // need a proper window to use bounds
    const CGSize windowSize = window.bounds.size;
    const CGFloat windowPortraitWidth = MIN(windowSize.width, windowSize.height);
    const CGFloat signatureViewWidth = windowPortraitWidth - (2 * SFStandardHorizontalMarginForView(window) + 2 * SFStandardLeftMarginForTableViewCell(window));
    return signatureViewWidth;
}

void SFUpdateScrollViewBottomInset(UIScrollView *scrollView, CGFloat bottomInset) {
    UIEdgeInsets insets = scrollView.contentInset;
    if (!SFCGFloatNearlyEqualToFloat(insets.bottom, bottomInset)) {
        CGPoint savedOffset = scrollView.contentOffset;
        
        insets.bottom = bottomInset;
        scrollView.contentInset = insets;
        
        insets = scrollView.scrollIndicatorInsets;
        insets.bottom = bottomInset;
        scrollView.scrollIndicatorInsets = insets;
        
        scrollView.contentOffset = savedOffset;
    }
}
