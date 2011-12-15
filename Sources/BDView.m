#import "BDView.h"

@implementation BDView

- (id)init {
    if (!(self = [super initWithFrame:NSZeroRect]))
        return nil;
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    NSSize screenSize = self.window.screen.frame.size;
    CGFloat width = screenSize.width / 14.0;
    
    [[NSColor colorWithCalibratedRed:1.0
                               green:0.0
                                blue:0.0
                               alpha:1.0] setStroke];
	
	[NSBezierPath setDefaultLineWidth:width];
	[[NSBezierPath bezierPathWithRect:NSMakeRect(width * .5, width * .5, screenSize.width - width, screenSize.height - width)] stroke];
}

@end
