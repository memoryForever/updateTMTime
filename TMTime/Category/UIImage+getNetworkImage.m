//
//  UIImage+getNetworkImage.m
//  TMTime
//
//  Created by 涂清文 on 16/4/4.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "UIImage+getNetworkImage.h"
#import "TQWMemCache.h"
#import <objc/runtime.h>
static NSUInteger count ;
@implementation UIImage (getNetworkImage)
//- (void)setCount:(NSUInteger)count{
//    objc_setAssociatedObject(self, @selector(count), count, OBJC_ASSOCIATION_ASSIGN);
//}
//- (NSUInteger)count{
//    objc_getAssociatedObject(self, _cmd);
//}

+(void)getNetworkImageURL:(NSString *)URL{
    NSURLSession *session = [NSURLSession sharedSession];
   NSURLSessionDataTask *task  =  [session dataTaskWithURL:[NSURL URLWithString:URL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *dataImage = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[TQWMemCache shareMemCache] addObject:dataImage forKey:[URL lastPathComponent]];
        });
    }];
    [task resume];
    return ;
}

+(void)getNetworkImageURL:(NSString *)URL completeHandler:(void (^)(UIImage *, NSError *))completeHandler{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:URL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            completeHandler(image,error);
        });
    }];
    [task resume];
}
+(void)getNetworkImageURL:(NSString *)URL Queue:(dispatch_queue_t)loadQueue completeHandler:(void(^)(UIImage *image ,NSError *error))completeHandler{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:URL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(loadQueue, ^{
            completeHandler(image,error);
        });
    }];
    [task resume];
}
+(void)getNetworkImageURLs:(NSArray<NSString *> *)URLStrs saveImageArray:(NSMutableArray<UIImage *> *)saveArray completeHandler:(void (^)(NSError *))completionHandler {
    if (!URLStrs.count) {
        return;
    }
  //  static NSInteger count = 0 ;
    kWeakSelf(mySelf);
    [URLStrs enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSURLSession *session = [NSURLSession sharedSession] ;
        NSURLSessionDataTask * dataTask = [session dataTaskWithURL:[NSURL URLWithString:obj] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            @synchronized(mySelf) {
                  count ++ ;
            }
            if (error) {
                dispatch_async_on_main_queue(^{
                   completionHandler(error);
                });
                return;
            }
            if (!data) {
                return;
            }
            @synchronized(mySelf) {
                [saveArray addObject:[UIImage imageWithData:data]];
            }
            NSLog(@"count:%ud",count);
            NSLog(@"URLStrs:%ud",URLStrs.count);
            if (count == URLStrs.count) {
                dispatch_async_on_main_queue(^{
                    completionHandler(nil);
                });
            }
        }];
        [dataTask resume];
    }];
    
}
@end
