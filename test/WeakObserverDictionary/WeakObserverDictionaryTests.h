#import <SenTestingKit/SenTestingKit.h>

#import "WeakObserverDictionary.h"

@interface WeakObserverDictionaryTests : SenTestCase

@property (nonatomic, strong) WeakObserverDictionary *observerDictionary;

@property (nonatomic, strong) id observer1;

@property (nonatomic, strong) id observer21;
@property (nonatomic, strong) id observer22;
@property (nonatomic, strong) id observer23;

@end
