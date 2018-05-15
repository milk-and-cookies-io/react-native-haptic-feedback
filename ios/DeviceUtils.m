//
//  DeviceUtils.m
//  RNReactNativeHapticFeedback
//
//  Created by Michael Kuczera on 13.05.18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceUtils.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation DeviceUtils;

+ (NSString *) platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

+ (int) deviceVersion:(NSString*) deviceType {
    
    NSString *platform = [self platform];
    int deviceVersion = 0;
    
    if ([platform containsString:deviceType]) {
        NSString *platformSplit = [platform componentsSeparatedByString:@","][0];
        deviceVersion = [[platformSplit substringFromIndex: [platformSplit length] - 1] intValue];
    }
    return deviceVersion;
}

@end;
