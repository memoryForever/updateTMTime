//
//  TQWDPRating.m
//  TMTime
//
//  Created by 涂清文 on 16/4/2.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWDPRating.h"

@implementation TQWDPRating

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{
             @"reviews" : [TQWDPRatingReviews class],
             @"additional_info":[TQWDPRatingAdditional_Info class],
             };
}
@end
@implementation TQWDPRatingAdditional_Info

@end


@implementation TQWDPRatingReviews

@end


