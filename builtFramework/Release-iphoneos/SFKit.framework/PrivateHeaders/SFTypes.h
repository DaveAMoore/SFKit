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


@import Foundation;
#import <SFKit/SFDefines.h>


NS_ASSUME_NONNULL_BEGIN

/**
 An enumeration of values that identify the different types of questions that the ResearchKit
 framework supports.
 */
typedef NS_ENUM(NSInteger, SFQuestionType) {
    /**
     No question.
     */
    SFQuestionTypeNone,
    
    /**
     The scale question type asks participants to place a mark at an appropriate position on a
     continuous or discrete line.
     */
    SFQuestionTypeScale,
    
    /**
     In a single choice question, the participant can pick only one predefined option.
     */
    SFQuestionTypeSingleChoice,
    
    /**
     In a multiple choice question, the participant can pick one or more predefined options.
     */
    SFQuestionTypeMultipleChoice,
    
    /**
     In a multiple component choice picker, the participant can pick one choice from each component.
     */
    SFQuestionTypeMultiplePicker,
    
    /**
     The decimal question type asks the participant to enter a decimal number.
     */
    SFQuestionTypeDecimal,
    
    /**
     The integer question type asks the participant to enter an integer number.
     */
    SFQuestionTypeInteger,
    
    /**
     The Boolean question type asks the participant to enter Yes or No (or the appropriate
     equivalents).
     */
    SFQuestionTypeBoolean,
    
    /**
     In a text question, the participant can enter multiple lines of text.
     */
    SFQuestionTypeText,
    
    /**
     In a time of day question, the participant can enter a time of day by using a picker.
     */
    SFQuestionTypeTimeOfDay,
    
    /**
     In a date and time question, the participant can enter a combination of date and time by using
     a picker.
     */
    SFQuestionTypeDateAndTime,
    
    /**
     In a date question, the participant can enter a date by using a picker.
     */
    SFQuestionTypeDate,
    
    /**
     In a time interval question, the participant can enter a time span by using a picker.
     */
    SFQuestionTypeTimeInterval,
    
    /**
     In a height question, the participant can enter a height by using a height picker.
     */
    SFQuestionTypeHeight,

    /**
     In a weight question, the participant can enter a weight by using a weight picker.
     */
    SFQuestionTypeWeight,
    
    /**
     In a location question, the participant can enter a location using a map view.
     */
    SFQuestionTypeLocation
} SF_ENUM_AVAILABLE;


/**
 An enumeration of the types of answer choices available.
 */
typedef NS_ENUM(NSInteger, SFChoiceAnswerStyle) {
    /**
     A single choice question lets the participant pick a single predefined answer option.
     */
    SFChoiceAnswerStyleSingleChoice,
    
    /**
     A multiple choice question lets the participant pick one or more predefined answer options.
     */
    SFChoiceAnswerStyleMultipleChoice
} SF_ENUM_AVAILABLE;


/**
 An enumeration of the format styles available for scale answers.
 */
typedef NS_ENUM(NSInteger, SFNumberFormattingStyle) {
    /**
     The default decimal style.
     */
    SFNumberFormattingStyleDefault,
    
    /**
     Percent style.
     */
    SFNumberFormattingStylePercent
} SF_ENUM_AVAILABLE;


/**
 You can use a permission mask to specify a set of permissions to acquire or
 that have been acquired for a task or step.
 */
typedef NS_OPTIONS(NSInteger, SFPermissionMask) {
    /// No permissions.
    SFPermissionNone                     = 0,
    
    /// Access to CoreMotion activity is required.
    SFPermissionCoreMotionActivity       = (1 << 1),
    
    /// Access to CoreMotion accelerometer data.
    SFPermissionCoreMotionAccelerometer  = (1 << 2),
    
    /// Access for audio recording.
    SFPermissionAudioRecording           = (1 << 3),
    
    /// Access to location.
    SFPermissionCoreLocation             = (1 << 4),
    
    /// Access to camera.
    SFPermissionCamera                   = (1 << 5),
} SF_ENUM_AVAILABLE;


/**
 File protection mode constants.
 
 The file protection mode constants correspond directly to `NSFileProtection` constants, but are
 more convenient to manipulate than strings. Complete file protection is
 highly recommended for files containing personal data that will be kept
 persistently.
 */
typedef NS_ENUM(NSInteger, SFFileProtectionMode) {
    /// No file protection.
    SFFileProtectionNone = 0,
    
    /// Complete file protection until first user authentication.
    SFFileProtectionCompleteUntilFirstUserAuthentication,
    
    /// Complete file protection unless there was an open file handle before lock.
    SFFileProtectionCompleteUnlessOpen,
    
    /// Complete file protection while the device is locked.
    SFFileProtectionComplete
} SF_ENUM_AVAILABLE;


/**
 Audio channel constants.
 */
typedef NS_ENUM(NSInteger, SFAudioChannel) {
    /// The left audio channel.
    SFAudioChannelLeft,
    
    /// The right audio channel.
    SFAudioChannelRight
} SF_ENUM_AVAILABLE;


/**
 Body side constants.
 */
typedef NS_ENUM(NSInteger, SFBodySagittal) {
    /// The left side.
    SFBodySagittalLeft,
    
    /// The right side.
    SFBodySagittalRight
} SF_ENUM_AVAILABLE;


/**
 Values that identify the left or right limb to be used in an active task.
 */
typedef NS_OPTIONS(NSUInteger, SFPredefinedTaskLimbOption) {
    /// Which limb to use is undefined
    SFPredefinedTaskLimbOptionUnspecified = 0,
    
    /// Task should test the left limb
    SFPredefinedTaskLimbOptionLeft = 1 << 1,
    
    /// Task should test the right limb
    SFPredefinedTaskLimbOptionRight = 1 << 2,
    
    /// Task should test the both limbs (random order)
    SFPredefinedTaskLimbOptionBoth = SFPredefinedTaskLimbOptionLeft | SFPredefinedTaskLimbOptionRight,
} SF_ENUM_AVAILABLE;


/**
 Values that identify the presentation mode of paced serial addition tests that are auditory and/or visual (PSAT).
 */
typedef NS_OPTIONS(NSInteger, SFPSATPresentationMode) {
    /// The PASAT (Paced Auditory Serial Addition Test).
    SFPSATPresentationModeAuditory = 1 << 0,
    
    /// The PVSAT (Paced Visual Serial Addition Test).
    SFPSATPresentationModeVisual = 1 << 1
} SF_ENUM_AVAILABLE;


/**
 Identify the type of passcode authentication for `SFPasscodeStepViewController`.
 */
typedef NS_ENUM(NSInteger, SFPasscodeType) {
    /// 4 digit pin entry
    SFPasscodeType4Digit,
    
    /// 6 digit pin entry
    SFPasscodeType6Digit
} SF_ENUM_AVAILABLE;


/**
 Values that identify the hand(s) to be used in an active task.
 
 By default, the participant will be asked to use their most affected hand.
 */
typedef NS_OPTIONS(NSUInteger, SFPredefinedTaskHandOption) {
    /// Which hand to use is undefined
    SFPredefinedTaskHandOptionUnspecified = 0,
    
    /// Task should test the left hand
    SFPredefinedTaskHandOptionLeft = 1 << 1,
    
    /// Task should test the right hand
    SFPredefinedTaskHandOptionRight = 1 << 2,
    
    /// Task should test both hands (random order)
    SFPredefinedTaskHandOptionBoth = SFPredefinedTaskHandOptionLeft | SFPredefinedTaskHandOptionRight,
} SF_ENUM_AVAILABLE;


/**
 The `SFPredefinedTaskOption` flags let you exclude particular behaviors from the predefined active
 tasks in the predefined category of `SFOrderedTask`.
 
 By default, all predefined tasks include instructions and conclusion steps, and may also include
 one or more data collection recorder configurations. Although not all predefined tasks include all
 of these data collection types, the predefined task option flags can be used to explicitly specify
 that a task option not be included.
 */
typedef NS_OPTIONS(NSUInteger, SFPredefinedTaskOption) {
    /// Default behavior.
    SFPredefinedTaskOptionNone = 0,
    
    /// Exclude the initial instruction steps.
    SFPredefinedTaskOptionExcludeInstructions = (1 << 0),
    
    /// Exclude the conclusion step.
    SFPredefinedTaskOptionExcludeConclusion = (1 << 1),
    
    /// Exclude accelerometer data collection.
    SFPredefinedTaskOptionExcludeAccelerometer = (1 << 2),
    
    /// Exclude device motion data collection.
    SFPredefinedTaskOptionExcludeDeviceMotion = (1 << 3),
    
    /// Exclude pedometer data collection.
    SFPredefinedTaskOptionExcludePedometer = (1 << 4),
    
    /// Exclude location data collection.
    SFPredefinedTaskOptionExcludeLocation = (1 << 5),
    
    /// Exclude heart rate data collection.
    SFPredefinedTaskOptionExcludeHeartRate = (1 << 6),
    
    /// Exclude audio data collection.
    SFPredefinedTaskOptionExcludeAudio = (1 << 7)
} SF_ENUM_AVAILABLE;


/**
 Progress indicator type for `SFWaitStep`.
 */
typedef NS_ENUM(NSInteger, SFProgressIndicatorType) {
    /// Spinner animation.
    SFProgressIndicatorTypeIndeterminate = 0,
    
    /// Progressbar animation.
    SFProgressIndicatorTypeProgressBar,
} SF_ENUM_AVAILABLE;


/**
 Measurement system.
 
 Used by SFHeightAnswerFormat and SFWeightAnswerFormat.
 */
typedef NS_ENUM(NSInteger, SFMeasurementSystem) {
    /// Measurement system in use by the current locale.
    SFMeasurementSystemLocal = 0,
    
    /// Metric measurement system.
    SFMeasurementSystemMetric,

    /// United States customary system.
    SFMeasurementSystemUSC,
} SF_ENUM_AVAILABLE;


/**
 Trailmaking Type Identifiers for supported trailmaking types.
 */
typedef NSString * SFTrailMakingTypeIdentifier NS_STRING_ENUM;

/// Trail making for Type-A trail where the pattern is 1-2-3-4-5-6-7
SF_EXTERN SFTrailMakingTypeIdentifier const SFTrailMakingTypeIdentifierA;

/// Trail making for Type-B trail where the pattern is 1-A-2-B-3-C-4-D-5-E-6-F-7
SF_EXTERN SFTrailMakingTypeIdentifier const SFTrailMakingTypeIdentifierB;


/**
 The `SFTremorActiveTaskOption` flags let you exclude particular steps from the predefined active
 tasks in the predefined Tremor `SFOrderedTask`.
 
 By default, all predefined active tasks will be included. The tremor active task option flags can
 be used to explicitly specify that an active task is not to be included.
 */
typedef NS_OPTIONS(NSUInteger, SFTremorActiveTaskOption) {
    /// Default behavior.
    SFTremorActiveTaskOptionNone = 0,
    
    /// Exclude the hand-in-lap steps.
    SFTremorActiveTaskOptionExcludeHandInLap = (1 << 0),
    
    /// Exclude the hand-extended-at-shoulder-height steps.
    SFTremorActiveTaskOptionExcludeHandAtShoulderHeight = (1 << 1),
    
    /// Exclude the elbow-bent-at-shoulder-height steps.
    SFTremorActiveTaskOptionExcludeHandAtShoulderHeightElbowBent = (1 << 2),
    
    /// Exclude the elbow-bent-touch-nose steps.
    SFTremorActiveTaskOptionExcludeHandToNose = (1 << 3),
    
    /// Exclude the queen-wave steps.
    SFTremorActiveTaskOptionExcludeQueenWave = (1 << 4)
} SF_ENUM_AVAILABLE;


/**
 Numeric precision.
 
 Used by SFWeightAnswerFormat.
 */
typedef NS_ENUM(NSInteger, SFNumericPrecision) {
    /// Default numeric precision.
    SFNumericPrecisionDefault = 0,
    
    /// Low numeric precision.
    SFNumericPrecisionLow,
    
    /// High numeric preicision.
    SFNumericPrecisionHigh,
} SF_ENUM_AVAILABLE;


extern const double SFDoubleDefaultValue SF_AVAILABLE_DECL;


NS_ASSUME_NONNULL_END
