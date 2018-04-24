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


@import UIKit;
#import "SFDefines.h"


NS_ASSUME_NONNULL_BEGIN

/// Color used for toolbar
SF_EXTERN NSString *const SFToolBarTintColorKey;

/// Color used for view's backgroud
SF_EXTERN NSString *const SFBackgroundColorKey;

/// Color used for signature
SF_EXTERN NSString *const SFSignatureColorKey;

/// Color used for a light-colored tint
SF_EXTERN NSString *const SFLightTintColorKey;

/// Color used for a dark-colored tint
SF_EXTERN NSString *const SFDarkTintColorKey;

/// Color used for caption text
SF_EXTERN NSString *const SFCaptionTextColorKey;

/// Color used for a "blue" highlight
SF_EXTERN NSString *const SFBlueHighlightColorKey;

/// Default color used for legend, title and text on SFPieChartView
SF_EXTERN NSString *const SFChartDefaultTextColorKey;

/// Default color used for axes of SFGraphChartView
SF_EXTERN NSString *const SFGraphAxisColorKey;

/// Default color used for titles on axes of SFGraphChartView
SF_EXTERN NSString *const SFGraphAxisTitleColorKey;

/// Default color used for scrubber line of SFGraphChartView
SF_EXTERN NSString *const SFGraphScrubberLineColorKey;

/// Default color used for scrubber thumb of SFGraphChartView
SF_EXTERN NSString *const SFGraphScrubberThumbColorKey;

/// Default color used for reference line of SFGraphChartView
SF_EXTERN NSString *const SFGraphReferenceLineColorKey;

/// Default color used for auxiliary image tint of SFInstructionStepView
SF_EXTERN NSString *const SFAuxiliaryImageTintColorKey;

/// Return the color for a specified SF...ColorKey
UIColor *SFColor(NSString *colorKey);

/// Modify the color for a specified SF...ColorKey. (for customization)
void SFColorSetColorForKey(NSString *key, UIColor *color);

@interface UIColor (SFColor)

+ (UIColor *)ork_midGrayTintColor;
+ (UIColor *)ork_redColor;
+ (UIColor *)ork_grayColor;
+ (UIColor *)ork_darkGrayColor;

@end

extern const CGFloat SFScreenMetricMaxDimension;

typedef NS_ENUM(NSInteger, SFScreenMetric) {
    SFScreenMetricTopToCaptionBaseline,
    SFScreenMetricFontSizeHeadline,
    SFScreenMetricMaxFontSizeHeadline,
    SFScreenMetricFontSizeSurveyHeadline,
    SFScreenMetricMaxFontSizeSurveyHeadline,
    SFScreenMetricFontSizeSubheadline,
    SFScreenMetricFontSizeFootnote,
    SFScreenMetricCaptionBaselineToFitnessTimerTop,
    SFScreenMetricCaptionBaselineToTappingLabelTop,
    SFScreenMetricCaptionBaselineToInstructionBaseline,
    SFScreenMetricInstructionBaselineToLearnMoreBaseline,
    SFScreenMetricLearnMoreBaselineToStepViewTop,
    SFScreenMetricLearnMoreBaselineToStepViewTopWithNoLearnMore,
    SFScreenMetricContinueButtonTopMargin,
    SFScreenMetricContinueButtonTopMarginForIntroStep,
    SFScreenMetricTopToIllustration,
    SFScreenMetricIllustrationToCaptionBaseline,
    SFScreenMetricIllustrationHeight,
    SFScreenMetricInstructionImageHeight,
    SFScreenMetricContinueButtonHeightRegular,
    SFScreenMetricContinueButtonHeightCompact,
    SFScreenMetricContinueButtonWidth,
    SFScreenMetricMinimumStepHeaderHeightForMemoryGame,
    SFScreenMetricMinimumStepHeaderHeightForTowerOfHanoiPuzzle,
    SFScreenMetricTableCellDefaultHeight,
    SFScreenMetricTextFieldCellHeight,
    SFScreenMetricChoiceCellFirstBaselineOffsetFromTop,
    SFScreenMetricChoiceCellLastBaselineToBottom,
    SFScreenMetricChoiceCellLabelLastBaselineToLabelFirstBaseline,
    SFScreenMetricLearnMoreButtonSideMargin,
    SFScreenMetricHeadlineSideMargin,
    SFScreenMetricToolbarHeight,
    SFScreenMetricVerticalScaleHeight,
    SFScreenMetricSignatureViewHeight,
    SFScreenMetricPSATKeyboardViewWidth,
    SFScreenMetricPSATKeyboardViewHeight,
    SFScreenMetricLocationQuestionMapHeight,
    SFScreenMetricTopToIconImageViewTop,
    SFScreenMetricIconImageViewToCaptionBaseline,
    SFScreenMetricVerificationTextBaselineToResendButtonBaseline,
    SFScreenMetric_COUNT
};

typedef NS_ENUM(NSInteger, SFScreenType) {
    SFScreenTypeiPhone6Plus,
    SFScreenTypeiPhone6,
    SFScreenTypeiPhone5,
    SFScreenTypeiPhone4,
    SFScreenTypeiPad,
    SFScreenTypeiPad12_9,
    SFScreenType_COUNT
};

SFScreenType SFGetVerticalScreenTypeForWindow(UIWindow * _Nullable window);
CGFloat SFGetMetricForWindow(SFScreenMetric metric, UIWindow * _Nullable window);

CGFloat SFStandardLeftMarginForTableViewCell(UIView *view);
CGFloat SFStandardHorizontalMarginForView(UIView *view);
UIEdgeInsets SFStandardLayoutMarginsForTableViewCell(UIView *view);
UIEdgeInsets SFStandardFullScreenLayoutMarginsForView(UIView *view);
UIEdgeInsets SFScrollIndicatorInsetsForScrollView(UIView *view);
CGFloat SFWidthForSignatureView(UIWindow * _Nullable window);

void SFUpdateScrollViewBottomInset(UIScrollView *scrollView, CGFloat bottomInset);


NS_ASSUME_NONNULL_END
