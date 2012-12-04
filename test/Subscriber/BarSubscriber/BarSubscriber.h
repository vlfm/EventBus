#import <Foundation/Foundation.h>

#import "BarEvent.h"

@interface BarSubscriber : NSObject

- (void) handleBarEvent: (BarEvent *)event;

@end
