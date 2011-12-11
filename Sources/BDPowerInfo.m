#import <IOKit/ps/IOPowerSources.h>
#import <IOKit/ps/IOPSKeys.h>

#import "BDPowerInfo.h"

@implementation BDPowerInfo

- (id)IOKitPowerSourceKey:(id)key {
    id result = nil;
    
    CFTypeRef info = IOPSCopyPowerSourcesInfo();
    CFArrayRef list = IOPSCopyPowerSourcesList(info);
    
    for(int i = 0; i < CFArrayGetCount(list); i++) {
        CFDictionaryRef description = IOPSGetPowerSourceDescription(info, CFArrayGetValueAtIndex(list, i));
        if(description != NULL) {
            result = (__bridge id)CFDictionaryGetValue(description, (__bridge void *)key);
            if(result)
                break;
        }
    }
    
    CFRelease(list);
    CFRelease(info);
    
    return result;
}

#pragma mark -

- (NSInteger)remainingCharge {
    NSInteger currentCharge = [[self IOKitPowerSourceKey:@kIOPSCurrentCapacityKey] integerValue];
    NSInteger maxCharge = [[self IOKitPowerSourceKey:@kIOPSMaxCapacityKey] integerValue];
    return (currentCharge * 100) / maxCharge;
}

- (BOOL)isRunningOnBattery {
    return [[self IOKitPowerSourceKey:@kIOPSPowerSourceStateKey] isEqualToString:@kIOPSBatteryPowerValue];
}

- (BOOL)isChargingBattery {
    return [[self IOKitPowerSourceKey:@kIOPSIsChargingKey] boolValue];
}

#pragma mark -

+ (id)sharedPowerInfo {
    static dispatch_once_t onceToken;
    static BDPowerInfo *powerInfo = nil;
    dispatch_once(&onceToken, ^{
        powerInfo = [[self alloc] init];
    });
    return powerInfo;
}

@end
