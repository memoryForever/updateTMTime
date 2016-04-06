//
//  TQWDouBanMovie.m
//  TMTime
//
//  Created by 涂清文 on 16/4/2.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWDouBanMovie.h"

@implementation TQWDouBanMovie

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{
             @"casts" : [TQWMovieCasts class],
             @"directors" : [TQWMovieDirectors class],
             @"images":[TQWMovieImages class],
             @"rating":[TQWMovieRating class],
             };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"movieID":@"id",
             };
}
@end


@implementation TQWMovieImages

@end


@implementation TQWMovieRating

@end


@implementation TQWMovieCasts
+ (NSDictionary *)modelCustomPropertMapper{
    return @{
             @"movieCastID":@"id",
             } ;
}
@end


@implementation TQWMovieCastsAvatars
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"avatars":[TQWMovieCastsAvatars class],
             };
}
@end


@implementation TQWMovieDirectors
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"avatars":[TQWMovieCastsAvatars class],
             };
}
+ (NSDictionary *)modelCustomPropertMapper{
    return @{
             @"MovieDirectorID" : @"id",
             };
}
@end





