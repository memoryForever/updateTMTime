//
//  TQWDPRating.h
//  TMTime
//
//  Created by 涂清文 on 16/4/2.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TQWDPRatingAdditional_Info,TQWDPRatingReviews;
@interface TQWDPRating : NSObject

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) NSArray<TQWDPRatingReviews *> *reviews;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) TQWDPRatingAdditional_Info *additional_info;

@end
@interface TQWDPRatingAdditional_Info : NSObject

@property (nonatomic, copy) NSString *more_reviews_url;

@end

@interface TQWDPRatingReviews : NSObject

@property (nonatomic, copy) NSString *text_excerpt;

@property (nonatomic, assign) NSInteger review_id;

@property (nonatomic, copy) NSString *rating_s_img_url;

@property (nonatomic, assign) NSInteger decoration_rating;

@property (nonatomic, assign) NSInteger service_rating;

@property (nonatomic, copy) NSString *user_nickname;

@property (nonatomic, copy) NSString *review_url;

@property (nonatomic, copy) NSString *rating_img_url;

@property (nonatomic, assign) NSInteger product_rating;

@property (nonatomic, copy) NSString *created_time;

@property (nonatomic, assign) NSInteger review_rating;

@end

