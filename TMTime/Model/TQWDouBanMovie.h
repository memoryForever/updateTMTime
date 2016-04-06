//
//  TQWDouBanMovie.h
//  TMTime
//
//  Created by 涂清文 on 16/4/2.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>



@class TQWMovieImages,TQWMovieRating,TQWMovieCasts,TQWMovieCastsAvatars,TQWMovieDirectors;
@interface TQWDouBanMovie : NSObject

@property (nonatomic, copy) NSString *subtype;

@property (nonatomic, copy) NSString *mobile_url;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *alt;

@property (nonatomic, strong) NSArray<TQWMovieDirectors *> *directors;

@property (nonatomic, assign) NSInteger collect_count;

@property (nonatomic, strong) TQWMovieImages *images;

@property (nonatomic, strong) NSArray<NSString *> *countries;

@property (nonatomic, assign) NSInteger wish_count;

@property (nonatomic, copy) NSString *do_count;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, copy) NSString *year;

@property (nonatomic, copy) NSString *original_title;

@property (nonatomic, assign) NSInteger comments_count;

@property (nonatomic, copy) NSString *schedule_url;

@property (nonatomic, copy) NSString *seasons_count;
//movieID : id
@property (nonatomic, copy) NSString *movieID;

@property (nonatomic, strong) NSArray<NSString *> *aka;

@property (nonatomic, assign) NSInteger reviews_count;

@property (nonatomic, strong) NSArray<TQWMovieCasts *> *casts;

@property (nonatomic, copy) NSString *douban_site;

@property (nonatomic, strong) NSArray<NSString *> *genres;

@property (nonatomic, copy) NSString *current_season;

@property (nonatomic, assign) NSInteger ratings_count;

@property (nonatomic, strong) TQWMovieRating *rating;

@property (nonatomic, copy) NSString *episodes_count;

@end

@interface TQWMovieImages : NSObject

@property (nonatomic, copy) NSString *small;

@property (nonatomic, copy) NSString *large;

@property (nonatomic, copy) NSString *medium;

@end

@interface TQWMovieRating : NSObject

@property (nonatomic, copy) NSString *stars;

@property (nonatomic, assign) CGFloat average;

@property (nonatomic, assign) NSInteger min;

@property (nonatomic, assign) NSInteger max;

@end

@interface TQWMovieCasts : NSObject
//movieCastID id
@property (nonatomic, copy) NSString *movieCastID;

@property (nonatomic, copy) NSString *alt;

@property (nonatomic, strong) TQWMovieCastsAvatars *avatars;

@property (nonatomic, copy) NSString *name;

@end

@interface TQWMovieCastsAvatars : NSObject

@property (nonatomic, copy) NSString *small;

@property (nonatomic, copy) NSString *large;

@property (nonatomic, copy) NSString *medium;

@end

@interface TQWMovieDirectors : NSObject
// MovieDirectorID id
@property (nonatomic, copy) NSString *MovieDirectorID;

@property (nonatomic, copy) NSString *alt;

@property (nonatomic, strong) TQWMovieCastsAvatars *avatars;

@property (nonatomic, copy) NSString *name;

@end


