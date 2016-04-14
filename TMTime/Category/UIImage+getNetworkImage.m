//
//  UIImage+getNetworkImage.m
//  TMTime
//
//  Created by 涂清文 on 16/4/4.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "UIImage+getNetworkImage.h"
#import "TQWMemCache.h"

@implementation UIImage (getNetworkImage)
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
@end
