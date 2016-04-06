//
//  TQWMemCache.h
//  TMTime
//
//  Created by 涂清文 on 16/4/4.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQWMemCache : NSObject
@property (nonatomic,assign)NSInteger maxContainer;
- (void)setMaxContainer:(NSInteger)maxContainer giveUpElement:(void(^)(NSString *key))giveUpElement;
- (void)addObject:(id)obj forKey:(NSString*)key;
- (void)removeObjectForKey:(NSString*)key;
- (void)removeObjectForKeys:(NSArray<NSString*>*)keys;
+ (instancetype)shareMemCache;
@end
