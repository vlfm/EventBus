#import <Foundation/Foundation.h>

@interface WeakObserverDictionary : NSObject

- (void) addObserver: (id)observer forKey: (id)key;

- (void) removeObserver: (id)observer forKey: (id)key;
- (void) removeObserverForAllKeys: (id)observer;
- (void) removeObserversForKey: (id)key;

- (NSArray *) getObserversForKey: (id)key;

@end
