#import <SenTestingKit/SenTestingKit.h>

#import "EventBus.h"
#import "FooEvent.h"
#import "BarEvent.h"
#import "FooSubscriber.h"
#import "BarSubscriber.h"
#import "FooBarSubscriber.h"

@interface EventBusTests : SenTestCase

@property (nonatomic, strong) EventBus *eventBus;

@property (nonatomic, strong) FooEvent *fooEvent;
@property (nonatomic, strong) BarEvent *barEvent;

@property (nonatomic, strong) id fooSubscriberMock;
@property (nonatomic, strong) id barSubscriberMock1;
@property (nonatomic, strong) id barSubscriberMock2;
@property (nonatomic, strong) id fooBarSubscriberMock;

@end
