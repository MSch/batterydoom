#import "BDAppDelegate.h"
#import "BDPowerInfo.h"

@implementation BDAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [BDWindow show];
    [BDWindow performSelector:@selector(hide) withObject:nil afterDelay:2];
    
    BDPowerInfo *powerInfo = [BDPowerInfo sharedPowerInfo];
    NSLog(@"%ld", powerInfo.remainingCharge);
    NSLog(@"%d", powerInfo.chargingBattery);
    NSLog(@"%d", powerInfo.runningOnBattery);
}

@end
