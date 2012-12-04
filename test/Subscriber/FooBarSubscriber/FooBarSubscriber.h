#import <Foundation/Foundation.h>

#import "FooEvent.h"
#import "BarEvent.h"

@interface FooBarSubscriber : NSObject

- (void) handleFooEvent: (FooEvent *)event;
- (void) handleBarEvent: (BarEvent *)event;

@end
