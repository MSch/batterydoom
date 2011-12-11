#import <Cocoa/Cocoa.h>
#import "BDView.h"

@interface BDWindow : NSWindow

@property (nonatomic, strong) BDView *contentView;

+ (void)setVisible:(BOOL)visible;
+ (void)show;
+ (void)hide;

@end
