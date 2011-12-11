#import <Quartz/Quartz.h>
#import "BDWindow.h"

static __strong BDWindow *sharedWindow;

@implementation BDWindow
@dynamic contentView;

- (id)init {
    NSScreen *screen = [[NSScreen screens] objectAtIndex:0];
    
    if (!(self = [self initWithContentRect:[screen frame]
                                 styleMask:NSBorderlessWindowMask
                                   backing:NSBackingStoreBuffered
                                     defer:NO
                                    screen:screen]))
        return nil;
    
    self.level = CGShieldingWindowLevel();
    self.backgroundColor = [NSColor clearColor];
    self.opaque = NO;
    self.ignoresMouseEvents = YES;
    self.collectionBehavior = NSWindowCollectionBehaviorCanJoinAllSpaces | NSWindowCollectionBehaviorStationary | NSWindowCollectionBehaviorIgnoresCycle;
    self.contentView = [[BDView alloc] init];
    
    return self;
}


#pragma mark -

+ (void)show {
    if (sharedWindow)
        return;
    
    sharedWindow = [[self alloc] init];
    [sharedWindow orderFrontRegardless];
}

+ (void)hide {
    if (!sharedWindow)
        return;
    
    [sharedWindow orderOut:nil];
    sharedWindow = nil;
}


#pragma mark -

// These don't appear to be necessary, but better safe than sorry

- (BOOL)acceptsFirstResponder {
    return NO;
}

- (BOOL)canBecomeKeyWindow {
    return NO;
}

- (BOOL)canBecomeMainWindow {
    return NO;
}

@end
