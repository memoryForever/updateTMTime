//
//  NSObject+LocationV2.h
//  TMTime
//
//  Created by tarena33 on 16/4/9.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 描述获取坐标失败 **/
#define kCoordinate2DOrigin CLLocationCoordinate2DMake(0, 0)

@class CLLocationManager;
typedef void(^TQW_Location_Block)(CLLocationCoordinate2D ,NSError*);

@interface NSObject (LocationV2) <CLLocationManagerDelegate> 
/** 位置管理者 **/
@property (nonatomic,strong) CLLocationManager* TQWLocationManager ;
/** 临时保存回调block **/
@property (nonatomic,copy)   TQW_Location_Block TQWGetLocationCompleterHandler;

@property (nonatomic,strong) CLGeocoder *TQWGeocoder ;
/**
 *  获取当前城市
 *
 *  @param CompleteHander 获取完成时调用block
 */
- (void)TQWLocationManagerDidGetCurrentCityNameCompleteHandler:(void(^)(NSString *cityName,NSError *error))CompleteHander;
/**
 *  获取当前纬经度
 *
 *  @param CompleteHandler 获取完成时调用
 */
- (void)TQWLocationManagerDidGetCurrentLocationCoordinateCompleteHandler:(void(^)(CLLocationCoordinate2D coordinate2D,NSError *error))CompleteHandler;
/**
 *  将地址转换为地址编码
 *
 *  @param address         地址
 *  @param CompleteHandler 完成时调用
 */
- (void)TQWLocationManagerAddress:(NSString*)address  ConvertGeocodingCompleteHandler:(void(^)(CLLocation *location,NSError *error))CompleteHandler;
/**
 *  获取指定坐标的详细信息
 *
 *  @param coordinate2D    纬经度
 *  @param CompleteHandler 完成时调用block
 */
- (void)TQWLocationManagerCoordinate2D:(CLLocationCoordinate2D)coordinate2D  ReverseGeocodingCompleteHandler:(void(^)(CLPlacemark *placemark ,NSError *error))CompleteHandler;
/**
 *  获取当前位置的详细信息
 *
 *  @param CompleteHandler 完成时调用
 */
- (void)TQWLocationManagerGetCurrentDetailLocationInfoCompletereHandler:(void(^)(CLPlacemark *placeMark,NSError*))CompleteHandler;
@end
