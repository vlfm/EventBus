#import "WeakReferenceWrapper.h"

@interface WeakReferenceWrapper ()

@property (nonatomic, weak, readwrite) id wrappedObject;

- (id) initWithWrappedObject: (id)wrappedObject;

@end

@implementation WeakReferenceWrapper

+ (WeakReferenceWrapper *) wrapObject: (id)object
{
    WeakReferenceWrapper *wrapper = [[WeakReferenceWrapper alloc] initWithWrappedObject:object];
    return wrapper;
}

- (id) initWithWrappedObject: (id)wrappedObject
{
    self = [super init];
    if (self != nil) {
        self.wrappedObject = wrappedObject;
    }
    return self;
}

- (BOOL) isEqual: (id)object
{
    if ([object isKindOfClass:[WeakReferenceWrapper class]]) {
        return [self.wrappedObject isEqual:[object wrappedObject]];
    }
    
    return [self.wrappedObject isEqual:object];
}

- (NSUInteger) hash
{
    return [self.wrappedObject hash];
}

@end
