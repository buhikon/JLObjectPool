//
//  JLBlockManager.h
//
//  Created by Joey L. on 3/16/15.
//
//

#import <Foundation/Foundation.h>

@interface JLObjectPool : NSObject

+ (NSString *)saveObject:(id)object;
+ (id)loadObject:(NSString *)key;
+ (void)deleteObject:(NSString *)key;

@end
