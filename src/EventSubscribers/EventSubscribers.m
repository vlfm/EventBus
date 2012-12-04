#import "EventSubscribers.h"

#import "WeakObserverDictionary.h"

@interface EventSubscribers ()

@property (nonatomic, strong) WeakObserverDictionary *subscribers;

@end

@implementation EventSubscribers

+ (EventSubscribers *) createEventSubscribers
{
    EventSubscribers *eventSubscribers = [[EventSubscribers alloc] init];
    return eventSubscribers;
}

- (id) init
{
    self = [super init];
    if (self != nil) {
        self.subscribers = [[WeakObserverDictionary alloc] init];
    }
    return self;
}

- (void) addSubscriber: (id)subscriber forEvent: (Class)event
{
    [self.subscribers addObserver:subscriber forKey:event];
}

- (void) removeSubscriber: (id)subscriber forEvent: (Class)event
{
    [self.subscribers removeObserver:subscriber forKey:event];
}

- (void) removeSubscriberForAllEvents: (id)subscriber
{
    [self.subscribers removeObserverForAllKeys:subscriber];
}

- (NSArray *) getSubscribersForEvent: (Class)event
{
    return [self.subscribers getObserversForKey:event];
}

@end
