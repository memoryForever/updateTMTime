//
//  TQWFindBussinessRespond.h
//  TMTime
//
//  Created by 涂清文 on 16/4/2.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TQWBusinesses;
@interface TQWFindBussinessRespond : NSObject

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) NSArray<TQWBusinesses *> *businesses;

@property (nonatomic, assign) NSInteger total_count;

@property (nonatomic, assign) NSInteger count;


@end

@interface TQWBusinesses : NSObject

@property (nonatomic, copy) NSString *branch_name;

@property (nonatomic, copy) NSString *rating_s_img_url;

@property (nonatomic, assign) NSInteger deal_count;

@property (nonatomic, copy) NSString *telephone;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *coupon_url;

@property (nonatomic, assign) NSInteger product_score;

@property (nonatomic, assign) NSInteger has_deal;

@property (nonatomic, copy) NSString *online_reservation_url;

@property (nonatomic, copy) NSString *review_list_url;

@property (nonatomic, copy) NSString *business_url;

@property (nonatomic, assign) NSInteger product_grade;

@property (nonatomic, copy) NSString *coupon_description;

@property (nonatomic, assign) NSInteger distance;

@property (nonatomic, copy) NSString *rating_img_url;

@property (nonatomic, assign) NSInteger avg_rating;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *photo_list_url;

@property (nonatomic, assign) CGFloat longitude;

@property (nonatomic, assign) NSInteger has_online_reservation;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, assign) CGFloat service_score;

@property (nonatomic, assign) NSInteger has_coupon;

@property (nonatomic, assign) NSInteger business_id;

@property (nonatomic, assign) NSInteger coupon_id;

@property (nonatomic, strong) NSArray *deals;

@property (nonatomic, strong) NSArray<NSString *> *categories;

@property (nonatomic, assign) NSInteger decoration_grade;

@property (nonatomic, assign) NSInteger service_grade;

@property (nonatomic, copy) NSString *photo_url;

@property (nonatomic, strong) NSArray<NSString *> *regions;

@property (nonatomic, assign) NSInteger avg_price;

@property (nonatomic, assign) NSInteger review_count;

@property (nonatomic, copy) NSString *s_photo_url;

@property (nonatomic, assign) NSInteger photo_count;

@property (nonatomic, assign) CGFloat decoration_score;

@property (nonatomic, assign) CGFloat latitude;

@end

