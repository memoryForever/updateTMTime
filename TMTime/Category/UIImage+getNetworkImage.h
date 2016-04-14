//
//  UIImage+getNetworkImage.h
//  TMTime
//
//  Created by 涂清文 on 16/4/4.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (getNetworkImage)
+(void)getNetworkImageURL:(NSString*)URL;
+(void)getNetworkImageURL:(NSString *)URL completeHandler:(void(^)(UIImage *image ,NSError *error))completeHandler;
+(void)getNetworkImageURL:(NSString *)URL Queue:(dispatch_queue_t)loadQueue completeHandler:(void(^)(UIImage *image ,NSError *error))completeHandler;
@end
