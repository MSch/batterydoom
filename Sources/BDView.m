#import "BDView.h"

@implementation BDView

- (id)init {
    if (!(self = [super initWithFrame:NSZeroRect]))
        return nil;
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    NSSize screenSize = self.window.screen.frame.size;
    CGFloat width = screenSize.width / 14;
    
    [[NSColor colorWithCalibratedRed:1.0
                               green:0.0
                                blue:0.0
                               alpha:0.5] setFill];
    
    // bottom
    NSRectFill(NSMakeRect(0, 0, screenSize.width, width));

    // top
    NSRectFill(NSMakeRect(0, screenSize.height - width, screenSize.width, width));
    
    // left
    NSRectFill(NSMakeRect(0, 0, width, screenSize.height));
    
    // right
    NSRectFill(NSMakeRect(screenSize.width - width, width, width, screenSize.height));
}

@end
