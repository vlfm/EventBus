#import "WeakObserverDictionary.h"

#import "WeakReferenceWrapper.h"

@interface WeakObserverDictionary ()

@property (nonatomic, strong) NSMutableDictionary *observers;

@end

@implementation WeakObserverDictionary

- (id) init
{
    self = [super init];
    if (self != nil) {
        self.observers = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void) addObserver: (id)observer forKey: (id)key
{
    NSMutableArray *keyObservers = [self.observers objectForKey:key];
    if (keyObservers == nil) {
        keyObservers = [NSMutableArray array];
        [self.observers setObject:keyObservers forKey:key];
    }
    
    WeakReferenceWrapper *weakReferenceToObserver = [WeakReferenceWrapper wrapObject:observer];
    [keyObservers addObject:weakReferenceToObserver];
}

- (void) removeObserver: (id)observer forKey: (id)key
{
    NSMutableArray *weakReferencesToObservers = [self.observers objectForKey:key];
    [weakReferencesToObservers removeObject:[WeakReferenceWrapper wrapObject:observer]];
}

- (void) removeObserverForAllKeys: (id)observer
{
    for (id key in [self.observers allKeys]) {
        [self removeObserver:observer forKey:key];
    }
}

- (void) removeObserversForKey: (id)key
{
    [self.observers removeObjectForKey:key];
}

- (NSArray *) getObserversForKey: (id)key
{
    NSArray *weakReferencesToObservers = [self.observers objectForKey:key];
    NSMutableArray *result = [NSMutableArray array];
    
    for (WeakReferenceWrapper *eachReference in weakReferencesToObservers) {
        id eachWrappedObject = [eachReference wrappedObject];
        if (eachWrappedObject)
        [result addObject:eachWrappedObject];
    }
    
    return result;
}

@end
