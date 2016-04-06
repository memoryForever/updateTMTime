//
//  UIImageView+LoadImage.h
//  TMTime
//
//  Created by 涂清文 on 16/4/4.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LoadImage)
/**
 *  载入图片
 *
 *  @param URL 图片地址
 */
- (void)loadImageWithURL:(NSString*)URL;
- (void)noTranformloadImageWithURL:(NSString *)URL;
@end
