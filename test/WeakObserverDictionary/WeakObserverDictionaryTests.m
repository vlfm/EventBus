#import "WeakObserverDictionaryTests.h"

@implementation WeakObserverDictionaryTests

- (void) setUp
{
    self.observerDictionary = [[WeakObserverDictionary alloc] init];
    
    self.observer1 = @"observer1";
    
    self.observer21 = @"observer21";
    self.observer22 = @"observer22";
    self.observer23 = @"observer23";
}

- (void) testAddObserver_oneObserver
{
    [self.observerDictionary addObserver:self.observer1 forKey:@"1"];
    
    NSArray *observers = [self.observerDictionary getObserversForKey:@"1"];
    
    STAssertEquals([observers count], (NSUInteger) 1, nil);
    STAssertEquals([observers objectAtIndex:0], self.observer1, nil);
}

- (void) testAddObserver_threeObservers
{
    [self.observerDictionary addObserver:self.observer21 forKey:@"2"];
    [self.observerDictionary addObserver:self.observer22 forKey:@"2"];
    [self.observerDictionary addObserver:self.observer23 forKey:@"2"];
    
    NSArray *observers = [self.observerDictionary getObserversForKey:@"2"];
    
    STAssertEquals([observers count], (NSUInteger) 3, nil);
    STAssertEquals([observers objectAtIndex:0], self.observer21, nil);
    STAssertEquals([observers objectAtIndex:1], self.observer22, nil);
    STAssertEquals([observers objectAtIndex:2], self.observer23, nil);
}

- (void) testAddObserver_twoKeys
{
    [self.observerDictionary addObserver:self.observer1 forKey:@"1"];
    [self.observerDictionary addObserver:self.observer21 forKey:@"2"];
    
    NSArray *observers1 = [self.observerDictionary getObserversForKey:@"1"];
    NSArray *observers2 = [self.observerDictionary getObserversForKey:@"2"];
    
    STAssertEquals([observers1 count], (NSUInteger) 1, nil);
    STAssertEquals([observers1 objectAtIndex:0], self.observer1, nil);
    
    STAssertEquals([observers2 count], (NSUInteger) 1, nil);
    STAssertEquals([observers2 objectAtIndex:0], self.observer21, nil);
}

- (void) testAddObserver_sameObserverMultipleTimesForSameKey
{
    [self.observerDictionary addObserver:self.observer1 forKey:@"1"];
    [self.observerDictionary addObserver:self.observer1 forKey:@"1"];
    
    NSArray *observers = [self.observerDictionary getObserversForKey:@"1"];
    
    STAssertEquals([observers count], (NSUInteger) 2, nil);
    STAssertEquals([observers objectAtIndex:0], self.observer1, nil);
    STAssertEquals([observers objectAtIndex:1], self.observer1, nil);
}

- (void) testRemoveObserver_oneObserver
{
    [self.observerDictionary addObserver:self.observer1 forKey:@"1"];
    [self.observerDictionary removeObserver:self.observer1 forKey:@"1"];
    
    NSArray *observers = [self.observerDictionary getObserversForKey:@"1"];
    
    STAssertEquals([observers count], (NSUInteger) 0, nil);
}

- (void) testRemoveObserver_threeObservers
{
    [self.observerDictionary addObserver:self.observer21 forKey:@"2"];
    [self.observerDictionary addObserver:self.observer22 forKey:@"2"];
    [self.observerDictionary addObserver:self.observer23 forKey:@"2"];
    
    [self.observerDictionary removeObserver:self.observer22 forKey:@"2"];
    
    NSArray *observers = [self.observerDictionary getObserversForKey:@"2"];
    
    STAssertEquals([observers count], (NSUInteger) 2, nil);
    STAssertEquals([observers objectAtIndex:0], self.observer21, nil);
    STAssertEquals([observers objectAtIndex:1], self.observer23, nil);
}

- (void) testRemoveObserver_sameObserverMultipleTimesForSameKey
{
    [self.observerDictionary addObserver:self.observer1 forKey:@"1"];
    [self.observerDictionary addObserver:self.observer1 forKey:@"1"];
    
    [self.observerDictionary removeObserver:self.observer1 forKey:@"1"];
    
    NSArray *observers = [self.observerDictionary getObserversForKey:@"1"];
    
    STAssertEquals([observers count], (NSUInteger) 0, nil);
}

- (void) testRemoveObserverForAllKeys
{
    [self.observerDictionary addObserver:self.observer1 forKey:@"1"];
    [self.observerDictionary addObserver:self.observer1 forKey:@"2"];
    
    [self.observerDictionary removeObserverForAllKeys:self.observer1];
    
    NSArray *observers1 = [self.observerDictionary getObserversForKey:@"1"];
    NSArray *observers2 = [self.observerDictionary getObserversForKey:@"2"];
    
    STAssertEquals([observers1 count], (NSUInteger) 0, nil);
    STAssertEquals([observers2 count], (NSUInteger) 0, nil);
}

- (void) testRemoveObserversForKey
{
    [self.observerDictionary addObserver:self.observer1 forKey:@"2"];
    [self.observerDictionary addObserver:self.observer21 forKey:@"2"];
    
    [self.observerDictionary removeObserversForKey:@"2"];
    
    NSArray *observers = [self.observerDictionary getObserversForKey:@"2"];
    
    STAssertEquals([observers count], (NSUInteger) 0, nil);
}

- (void) testAddObserver_observerWasNilled_returnsNothing
{
    NSData *strongObserver = [[NSData alloc] init];
    
    [self.observerDictionary addObserver:strongObserver forKey:@"1"];
    
    strongObserver = nil;
    
    NSArray *observers1 = [self.observerDictionary getObserversForKey:@"1"];
    
    STAssertEquals([observers1 count], (NSUInteger) 0, nil);
}

@end
