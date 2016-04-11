//
//  NSObject+Parser.m
//  TMTime
//
//  Created by 涂清文 on 16/4/1.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "NSObject+Parser.h"

@implementation NSObject (Parser)

+(void)parserData:(NSString *)stringURL params:(NSDictionary *)params modelClass:(Class)classes completeHandler:(void (^)(id, NSError *))completeHandler{
    kWeakSelf(mySelf);
        [mySelf GET:stringURL params:params completeHandler:^(id respondObject, NSError *error) {
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                 //NSLog(@"%@",[NSThread currentThread])  ;
                if ([respondObject isKindOfClass:[NSDictionary class]]) {
                    id data = [classes modelWithJSON:respondObject];
                    completeHandler(data,error);
                }
                if ([respondObject isKindOfClass:[NSArray class]]) {
                    id data   =  [NSArray modelArrayWithClass:classes json:respondObject];
                    completeHandler(data,error);
                }
            });
            
        }];
}
+(id)parserJson:(id)json{
    if ([json isKindOfClass:[NSArray class]]) {
        return [NSArray modelArrayWithClass:[self class] json:json];
    }
    if ([json isKindOfClass:[NSDictionary class]]) {
        return [self modelWithJSON:json];
    }
    return json ;
}
@end
