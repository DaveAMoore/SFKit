//
//  SFModelCheck.m
//  SFKit
//
//  Created by David Moore on 12/15/17.
//  Copyright © 2017 Moore Development. All rights reserved.
//

#import "SFModelCheck.h"
#import <sys/utsname.h>

@implementation SFModelCheck

+ (BOOL)is_iPhoneX {
    // Declare the interal result.
    static BOOL result = NO;
    
    // Declare a once token.
    static dispatch_once_t onceToken;
    
    // Initialize the static boolean one time.
    dispatch_once(&onceToken, ^{
        NSString *model;
        
#if TARGET_IPHONE_SIMULATOR
        // Get the model identifier from the simulator's process information.
        model = NSProcessInfo.processInfo.environment[@"SIMULATOR_MODEL_IDENTIFIER"];
#else
        // Declare and initialize the system info structure.
        struct utsname systemInfo;
        uname(&systemInfo);
        
        // Create the model string from the machine identifier.
        model = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
#endif
        
        // Determine the result by equating the two model strings.
        result = [model isEqualToString:@"iPhone 10,3"] || [model isEqualToString:@"iPhone10,6"];
    });
    
    return result;
}

@end
