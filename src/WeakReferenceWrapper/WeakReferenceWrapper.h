#import <Foundation/Foundation.h>

@interface WeakReferenceWrapper : NSObject

@property (nonatomic, weak, readonly) id wrappedObject;

+ (WeakReferenceWrapper *) wrapObject: (id)object;

@end
