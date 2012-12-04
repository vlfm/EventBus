#import "EventBus.h"

#import "EventSubscribers.h"

@interface EventBus ()

@property (nonatomic, strong) EventSubscribers *subscribers;

- (NSString *) selectorNameForEvent: (Class)event;

@end

@implementation EventBus

+ (EventBus *) createEventBus
{
    EventBus *eventBus = [[EventBus alloc] init];
    return eventBus;
}

- (id) init
{
    self = [super init];
    if (self != nil) {
        self.subscribers = [EventSubscribers createEventSubscribers];
    }
    return self;
}

- (void) subscribeForEvent: (Class)event subscriber: (id)subscriber
{
    NSString *selectorName = [self selectorNameForEvent:event];
    
    if (![subscriber respondsToSelector:NSSelectorFromString(selectorName)]) {
        NSString *reason = [NSString stringWithFormat:@"Subscriber should respond to %@ selector", selectorName];
        @throw [NSException exceptionWithName:@"" reason:reason userInfo:nil];
    }

    [self.subscribers addSubscriber:subscriber forEvent:event];
}

- (void) unsubscribeFromEvent: (Class)event subscriber: (id)subscriber
{
    [self.subscribers removeSubscriber:subscriber forEvent:event];
}

- (void) unsubscribeFromAllEvents: (id)subscriber
{
    [self.subscribers removeSubscriberForAllEvents:subscriber];
}

- (void) publishEvent: (id)event
{
    NSString *selectorName = [self selectorNameForEvent:[event class]];
    
    for (id subscriber in [self.subscribers getSubscribersForEvent:[event class]]) {
        [subscriber performSelector:NSSelectorFromString(selectorName) withObject:event];
    }
}

- (NSString *) selectorNameForEvent: (Class)event
{
    NSMutableString *selectorName = [NSMutableString string];
    [selectorName appendString:@"handle"];
    [selectorName appendString:NSStringFromClass(event)];
    [selectorName appendString:@":"];
    return selectorName;
}

@end
