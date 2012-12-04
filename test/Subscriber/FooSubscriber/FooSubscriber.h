#import <Foundation/Foundation.h>

#import "FooEvent.h"

@interface FooSubscriber : NSObject

- (void) handleFooEvent: (FooEvent *)event;

@end
