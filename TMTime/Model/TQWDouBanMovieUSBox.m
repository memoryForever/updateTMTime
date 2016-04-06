//
//  TQWDouBanMovieUSBox.m
//  TMTime
//
//  Created by 涂清文 on 16/4/2.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWDouBanMovieUSBox.h"
#import "TQWDouBanMovie.h"

@implementation TQWDouBanMovieUSBox

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{
             @"subjects" : [TQWUSBoxSubjects  class],
             };
}
@end



@implementation TQWUSBoxSubjects
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{
             @"subject" : [TQWUSBoxSubjectsSubject  class],
             };
}
@end


@implementation TQWUSBoxSubjectsSubject

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{
             @"casts" : [TQWUSBoxSubjectsSubjectCasts class],
             @"directors" : [TQWUSBoxSubjectsSubjectDirectors class],
             @"rating":[TQWUSBoxSubjectsSubjectRating class],
             @"images":[TQWUSBoxSubjectsSubjectImages class],
             };
}

@end


@implementation TQWUSBoxSubjectsSubjectImages

@end


@implementation TQWUSBoxSubjectsSubjectRating

@end


@implementation TQWUSBoxSubjectsSubjectCasts
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{
             @"avatars":[TQWUSBoxSubjectsSubjectCastsAvatars class],
             };
}
@end


@implementation TQWUSBoxSubjectsSubjectCastsAvatars

@end


@implementation TQWUSBoxSubjectsSubjectDirectors

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{
             @"avatars":[TQWUSBoxSubjectsSubjectCastsAvatars class],
             };
}

@end




