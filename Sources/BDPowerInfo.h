#import <Foundation/Foundation.h>

@interface BDPowerInfo : NSObject

@property (nonatomic, readonly) NSInteger remainingCharge;
@property (nonatomic, readonly, getter=isRunningOnBattery) BOOL runningOnBattery;
@property (nonatomic, readonly, getter=isChargingBattery) BOOL chargingBattery;

+ (id)sharedPowerInfo;

@end
