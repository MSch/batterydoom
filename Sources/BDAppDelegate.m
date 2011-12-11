#import "BDAppDelegate.h"
#import "BDPowerInfo.h"

static NSInteger const BDChargeThreshold = 5;
static NSInteger const BDPollingInterval = 5;

@interface BDAppDelegate ()
- (void)checkForLowCharge;
@end

@implementation BDAppDelegate {
    NSTimer *timer;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    timer = [NSTimer scheduledTimerWithTimeInterval:BDPollingInterval
                                             target:self
                                           selector:@selector(checkForLowCharge)
                                           userInfo:nil
                                            repeats:YES];
    [self checkForLowCharge];
}

- (void)checkForLowCharge {
    BDPowerInfo *powerInfo = [BDPowerInfo sharedPowerInfo];
    [BDWindow setVisible:(powerInfo.runningOnBattery && !powerInfo.chargingBattery && (powerInfo.remainingCharge < BDChargeThreshold))];
}

@end
