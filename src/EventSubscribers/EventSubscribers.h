#import <Foundation/Foundation.h>

@interface EventSubscribers : NSObject

+ (EventSubscribers *) createEventSubscribers;

- (void) addSubscriber: (id)subscriber forEvent: (Class)event;

- (void) removeSubscriber: (id)subscriber forEvent: (Class)event;
- (void) removeSubscriberForAllEvents: (id)subscriber;

- (NSArray *) getSubscribersForEvent: (Class)event;

@end
