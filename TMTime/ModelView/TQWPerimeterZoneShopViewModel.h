//
//  TQWPerimeterZoneShopViewModel.h
//  TMTime
//
//  Created by tarena33 on 16/4/8.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kBussinessTypeFooder      @"美食"
#define kBussinessTypeCinema      @"电影"
#define kBussinessTypeHotel       @"酒店"
#define kBussinessTypeSupermarker @"超市"

typedef NS_ENUM(NSInteger , BussinessType) {
    BussinessTypeFooder = 1 ,
    BussinessTypeCinema  ,
    BussinessTypeHotel ,
    BussinessTypeSupermarker ,
};

@interface TQWPerimeterZoneShopViewModel : NSObject
//视图属性
//table view 属性相关
/** 行数 **/
- (NSUInteger)rowNumber;
/** 商品图片URLString **/
- (NSString *)bussinessImageURLStringWithIndex:(NSUInteger)index;
/** 商品名 **/
- (NSString *)bussinessNameWithIndex:(NSUInteger)index;
/** 商品价格 **/
- (NSString *)bussinessPriceWthIndex:(NSUInteger)index;
/** 商品折扣 **/
- (NSString *)bussinessDisCountWithIndex:(NSInteger)index;
/** 商品与用户距离 **/
- (NSString *)bussinessDistanceWithIndex:(NSInteger)index;
/** 商品预约URLStirng ,返回空,不能再线预约**/
- (NSString *)bussinessReservationWithIndex:(NSInteger)index ;
//Model 属性
/** 获取商品信息 **/
- (void)getBussinessInfoCompleteHandler:(void(^)(NSError *error))completeHandler;
@end
