#import <Foundation/Foundation.h>

@interface EventBus : NSObject

+ (EventBus *) createEventBus;

- (void) subscribeForEvent: (Class)event subscriber: (id)subscriber;

- (void) unsubscribeFromEvent: (Class)event subscriber: (id)subscriber;
- (void) unsubscribeFromAllEvents: (id)subscriber;

- (void) publishEvent: (id)event;

@end
