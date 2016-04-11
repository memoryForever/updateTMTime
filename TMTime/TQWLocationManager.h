//
//  TQWLocationManager.h
//  TMTime
//
//  Created by tarena33 on 16/4/9.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQWLocationManager : NSObject
/**
 *  获取当前城市
 *
 *  @param CompleteHander 获取完成时调用block
 */
+ (void)LocationManagerDidGetCurrentCityNameCompleteHandler:(void(^)(NSString *cityName,NSError *error))CompleteHander;
/**
 *  获取当前纬经度
 *
 *  @param CompleteHandler 获取完成时调用
 */
+ (void)LocationManagerDidGetCurrentLocationCoordinateCompleteHandler:(void(^)(CLLocationCoordinate2D coordinate2D,NSError *error))CompleteHandler;
/**
 *  将地址转换为地址编码
 *
 *  @param address         地址
 *  @param CompleteHandler 完成时调用
 */
//+ (void)LocationManagerAddress:(NSString*)address  ConvertGeocodingCompleteHandler:(void(^)(CLLocation *location))CompleteHandler;
/**
 *  将坐标转换成城市名
 *
 *  @param coordinate2D    纬经度
 *  @param CompleteHandler 完成时调用block
 */
+ (void)LocationManagerCoordinate2D:(CLLocationCoordinate2D)coordinate2D  ReverseGeocodingCompleteHandler:(void(^)(NSString *cityName ,NSError *error))CompleteHandler;

@end
