//
//  TQWDBRequestFindBussiness.h
//  TMTime
//
//  Created by 涂清文 on 16/4/2.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger ,MapType) {
    MapTypeNone,
    MapTypeGaoDe,
    MapTypeTuba,
};
typedef NS_ENUM(NSInteger,SortRule) {
    SortRuleNone = 1,
    SortRuleStarLevel,
    SortRuleProductRating,
    SortRuleEnvironmentRating,
    SortRuleServeRating,
    SortRuleRatingCount,
    SortRuleNearby,
    SortRuleAveragePriceLow,
    SortRuleAveragePriceHigh,
};

@interface TQWDBRequestFindBussiness : NSObject
@property(nonatomic,assign)CGFloat latitude;
@property(nonatomic,assign)CGFloat longitude;
@property(nonatomic,assign)MapType mapType;
@property(nonatomic,assign)NSUInteger radius;
@property(nonatomic,copy)NSString *city ;
@property(nonatomic,copy)NSString *region;
@property(nonatomic,copy)NSString *category;
@property(nonatomic,copy)NSString *keyword;
@property(nonatomic,assign)BOOL hasCoupon;
@property(nonatomic,assign)BOOL hasDeal;
@property(nonatomic,assign)BOOL hasOnlineReservation;
@property(nonatomic,assign)SortRule sortRule;
@property(nonatomic,assign)NSInteger limitPaginalMaxBuessinesCount;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,copy)NSString *dataFormat;
+(instancetype)defaultRequest;
-(NSDictionary*)getParams;
@end
