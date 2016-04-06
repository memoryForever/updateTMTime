//
//  TQWMemCache.m
//  TMTime
//
//  Created by 涂清文 on 16/4/4.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#define kDefaultMaxContainer 18
typedef void(^GiveUpElemen_block)(NSString *key);

#import "TQWMemCache.h"
@interface TQWMemCache() <NSCopying>
/** 保存对象的容器 **/
@property(nonatomic ,strong) NSMutableDictionary *container;
/** 保存键值的数组 **/
@property(nonatomic ,strong) NSMutableArray *keys ;
/** 丢弃时调用,并返回删除的键值 **/

@property(nonatomic, copy)GiveUpElemen_block giveUpElement;
@end
static id _shareObject;
@implementation TQWMemCache

#pragma mark - 懒加载
- (NSMutableDictionary *)container{
    if (!_container) {
        _container = [NSMutableDictionary dictionary];
        _keys = [NSMutableArray arrayWithCapacity:kDefaultMaxContainer];
        if (!_maxContainer) {
            _maxContainer = kDefaultMaxContainer;
        }
    }
    return  _container;
}


#pragma mark - 类方法
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareObject = [super allocWithZone:zone];
    });
    return _shareObject;
}
+ (instancetype)alloc{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareObject = [super alloc];
    });
    return _shareObject;
}

+ (instancetype)shareMemCache{
    return [[TQWMemCache alloc]init];
}
#pragma mark - 实例方法
- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareObject = [super init];
    });
    return _shareObject;
}

- (void)addObject:(id)obj forKey:(NSString *)key{
    if ((_keys.count + 1) > _maxContainer ) {
        NSString *str = [_keys firstObject];
        [self removeObjectForKey:str];
        if (!_giveUpElement) {
            _giveUpElement(str);
        }
    }
    [_keys insertObject:key atIndex:_keys.count + 1 ];
    [self.container setObject:obj forKey:key];
}

- (void)removeObjectForKey:(NSString *)key{
    [_keys removeObject:key];
    [self.container removeObjectForKey:key];
}

- (void)removeObjectForKeys:(NSArray<NSString *> *)keys{
    [_keys removeObjectsInArray:keys];
    [self.container removeObjectsForKeys:keys];
}

- (id)copyWithZone:(NSZone *)zone{
    return _shareObject;
}

-(void)setMaxContainer:(NSInteger)maxContainer giveUpElement:(void (^)(NSString *))giveUpElement{
    _maxContainer = maxContainer;
    _giveUpElement = giveUpElement;
}

#pragma mark - 私有方法



@end
