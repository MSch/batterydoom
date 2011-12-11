#import "BDAppDelegate.h"

@implementation BDAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [BDWindow show];
    [BDWindow performSelector:@selector(hide) withObject:nil afterDelay:2];
}

@end
