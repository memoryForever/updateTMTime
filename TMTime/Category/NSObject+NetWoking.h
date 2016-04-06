//
//  NSObject+NetWoking.h
//  TMTime
//
//  Created by 涂清文 on 16/4/1.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NetWoking)
+(void)GET:(NSString *)stringURL params:(NSDictionary*)params completeHandler:(void(^)(id respondObject,NSError *error))completeHandler;

+(void)POST:(NSString *)stringURL params:(NSDictionary*)params completeHandler:(void(^)(id respondObject,NSError *error))completeHandler;

+(void)read:(NSString*)name completeHandler:(void(^)(id respondObject, NSError *error)) completeHandler;
@end
