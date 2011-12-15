#import <Quartz/Quartz.h>
#import "BDWindow.h"

static __strong BDWindow *sharedWindow;
static __strong NSSound *alertSound;

@interface BDWindow ()
- (void)tick:(NSTimer *)timer;
@end

@implementation BDWindow {
	NSTimer *tick;
	CGFloat time;
	NSDate *lastFrame;
}
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
	
	time = 0.0;
	lastFrame = [NSDate date];
	tick = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    
    return self;
}

- (void)dealloc {
	[tick invalidate];
}

- (void)tick:(NSTimer *)timer {
	time += -[lastFrame timeIntervalSinceNow];
	lastFrame = [NSDate date];
	self.alphaValue = sin(time * 4.0) * .4 + .4;
}

#pragma mark -

+ (void)setVisible:(BOOL)visible {
    if (visible)
        [self show];
    else
        [self hide];
}

+ (void)show {
    if (sharedWindow)
        return;
    
    sharedWindow = [[self alloc] init];
    [sharedWindow orderFrontRegardless];
	
	if (!alertSound) {
		alertSound = [NSSound soundNamed:@"redalert"];
		alertSound.loops = YES;
		[alertSound play];
	}
}

+ (void)hide {
    if (!sharedWindow)
        return;
    
    [sharedWindow close];
    sharedWindow = nil;

	[alertSound stop];
	alertSound = nil;
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
