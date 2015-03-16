//
//  JLBlockManager.m
//  BlockManagerDemo
//
//  Created by Joey L. on 3/16/15.
//
//

#import "JLObjectPool.h"

@interface JLObjectPool ()
@property (nonatomic, strong) NSMutableDictionary *objectArray;

@end

@implementation JLObjectPool

static JLObjectPool *instance = nil;
static long _uniqueKey = 1;

#pragma mark -
#pragma mark singleton

+ (JLObjectPool *)sharedInstance
{
    @synchronized(self)
    {
        if (!instance)
            instance = [[JLObjectPool alloc] init];
        return instance;
    }
}

#pragma mark - accessor

- (NSMutableDictionary *)objectArray
{
    if(!_objectArray) {
        _objectArray = [[NSMutableDictionary alloc] init];
    }
    return _objectArray;
}

#pragma mark - private methods

- (NSString *)generateKey
{
    return [NSString stringWithFormat:@"%ld", ++_uniqueKey];
}

#pragma mark - public methods

+ (NSString *)saveObject:(id)object
{
    if(!object) return nil;
    
    @try {
        @synchronized(self) {
            JLObjectPool *instance = [JLObjectPool sharedInstance];
            NSString *key = [instance generateKey];
            [instance.objectArray setObject:object forKey:key];
            return key;
        }
    }
    @catch (NSException *exception) {
        return nil;
    }
}

+ (id)loadObject:(NSString *)key
{
    if(key.length == 0) return nil;
    
    @try {
        @synchronized(self) {
            JLObjectPool *instance = [JLObjectPool sharedInstance];
            id result = instance.objectArray[key];
            return result;
        }
    }
    @catch (NSException *exception) {
        return nil;
    }
}

+ (void)deleteObject:(NSString *)key
{
    if(key.length == 0) return;
    
    @try {
        @synchronized(self) {
            JLObjectPool *instance = [JLObjectPool sharedInstance];
            [instance.objectArray removeObjectForKey:key];
        }
    }
    @catch (NSException *exception) {}
}

@end
