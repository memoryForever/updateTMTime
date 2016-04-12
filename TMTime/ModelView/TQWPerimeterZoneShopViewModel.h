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

@class TQWAnnotation;

typedef  NS_ENUM(NSInteger ,RefershType) {
    //城市改变刷新
    RefershTypeCityChange,
    //加载更多数据,下拉刷新
    RefershTypeLoadModeData,
    //上拉刷新
    RefershTypePullUp,
    //重新定位刷新
    RefershTypeRelocation,
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
//mapView相关
/** 商品的2d坐标 **/
- (CLLocationCoordinate2D)bussinessCoordiate2DWithIndex:(NSInteger)index;
/** 大头针下标 **/
- (TQWAnnotation*)bussinessAnnotationWithIndex:(NSInteger)index;
/** 获取当前显示的类别,和关键字 **/
- (void)bussinessFindCurrentInfo:(void(^)(NSString *category , NSString* keyword ))currentInfo;
//Model 属性
/** 获取商品信息 **/
- (void)getBussinessInfoCompleteHandler:(void(^)(NSError *error))completeHandler;
/**
 *  刷新
 *
 *  @param type 刷新类型
 */
- (void)refershDataAndRefersh:(RefershType)type;
/**
 *  企业搜索
 *
 *  @param type    类型
 *  @param keyword 关键字
 */
- (void)bussinessSearchCategory:(BussinessType)type keyword:(NSString*)keyword;


@end
