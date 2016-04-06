//
//  NSObject+NetWoking.m
//  TMTime
//
//  Created by 涂清文 on 16/4/1.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "NSObject+NetWoking.h"
#import <AFNetworking.h>

@implementation NSObject (NetWoking)
+(void)GET:(NSString *)stringURL params:(NSDictionary *)params completeHandler:(void (^)(id, NSError *))completeHandler{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //防止返回的格式不正确,导致程序crash ,这样不能使用afhttpsessionManger自带解析json的功能;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"text/json",@"text/javascript",@"application/json", nil];
    [manager GET:stringURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completeHandler(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络错误error: %@",error);
        completeHandler(nil,error);
    }];
}

+(void)POST:(NSString *)stringURL params:(NSDictionary *)params completeHandler:(void (^)(id, NSError *))completeHandler{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"text/json",@"text/javascript",@"application/json", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
   ;
    [manager POST:stringURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completeHandler(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completeHandler(nil,error);
    }];
    
    
    return ;
}
+ (void)read:(NSString *)name completeHandler:(void (^)(id, NSError *))completeHandler{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]];
        if (!array.count) {
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completeHandler(array,nil);
        });
    });
}

@end
