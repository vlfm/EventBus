#import "EventBusTests.h"

#import "OCMock.h"

@implementation EventBusTests

- (void) setUp
{
    self.eventBus = [EventBus createEventBus];
    
    self.fooEvent = [[FooEvent alloc] init];
    self.barEvent = [[BarEvent alloc] init];
    
    self.fooSubscriberMock = [OCMockObject mockForClass:[FooSubscriber class]];
    self.barSubscriberMock1 = [OCMockObject mockForClass:[BarSubscriber class]];
    self.barSubscriberMock2 = [OCMockObject mockForClass:[BarSubscriber class]];
    self.fooBarSubscriberMock = [OCMockObject mockForClass:[FooBarSubscriber class]];
}

- (void) testSubscribeForEvent_subscriberNotRepondsToSelector_throwsException
{
    @try {
        [self.eventBus subscribeForEvent:[BarEvent class] subscriber:self.fooSubscriberMock];
        @throw [NSException exceptionWithName:@"Test fail" reason:@"should throw exception" userInfo:nil];
    }
    @catch (NSException *exception) {
        NSString *expectedReason = @"Subscriber should respond to handleBarEvent: selector";
        STAssertEqualObjects(exception.reason, expectedReason, nil);
    }
}

- (void) testSubscribeForEvent_subscriberRespondsToSelector_notThrowsException
{
    [self.eventBus subscribeForEvent:[FooEvent class] subscriber:self.fooSubscriberMock];
}

- (void) testPublishEvent_subscriberReceivesEvent
{
    [[self.fooSubscriberMock expect] handleFooEvent:self.fooEvent];
    
    [self.eventBus subscribeForEvent:[FooEvent class] subscriber:self.fooSubscriberMock];
    [self.eventBus publishEvent:self.fooEvent];
    
    [self.fooSubscriberMock verify];
}

- (void) testPublishEvent_multipleSubscribers_subscribersReceiveEvent
{
    [[self.fooSubscriberMock expect] handleFooEvent:self.fooEvent];
    [[self.fooBarSubscriberMock expect] handleFooEvent:self.fooEvent];
    
    [self.eventBus subscribeForEvent:[FooEvent class] subscriber:self.fooSubscriberMock];
    [self.eventBus subscribeForEvent:[FooEvent class] subscriber:self.fooBarSubscriberMock];
    
    [self.eventBus publishEvent:self.fooEvent];
    
    [self.fooSubscriberMock verify];
    [self.fooBarSubscriberMock verify];
}

- (void) testUnsubscribeFromEvent
{
    [[self.fooSubscriberMock reject] handleFooEvent:self.fooEvent];
    
    [self.eventBus subscribeForEvent:[FooEvent class] subscriber:self.fooSubscriberMock];
    [self.eventBus unsubscribeFromEvent:[FooEvent class] subscriber:self.fooSubscriberMock];
    
    [self.eventBus publishEvent:self.fooEvent];
    
    [self.fooSubscriberMock verify];
}

- (void) testUnsubscribeFromAllEvents
{
    [[self.fooBarSubscriberMock reject] handleFooEvent:self.fooEvent];
    [[self.fooBarSubscriberMock reject] handleBarEvent:self.barEvent];
    
    [self.eventBus subscribeForEvent:[FooEvent class] subscriber:self.fooBarSubscriberMock];
    [self.eventBus subscribeForEvent:[BarEvent class] subscriber:self.fooBarSubscriberMock];
    
    [self.eventBus unsubscribeFromAllEvents:self.fooBarSubscriberMock];
    
    [self.eventBus publishEvent:self.fooEvent];
    [self.eventBus publishEvent:self.barEvent];
    
    [self.fooBarSubscriberMock verify];
}

@end
