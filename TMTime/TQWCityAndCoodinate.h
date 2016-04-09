//
//  TQWCityAndCoodinate.h
//  天气APP
//
//  Created by tarena33 on 16/3/24.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface TQWCityAndCoodinate : NSObject

+(void)getCurrentCoordinate:(void(^)(CLLocation*))currentLocationBlock;

+(void)getCurrentCity:(void(^)(NSString*)) currentLocationCityBlock;
+(void)getCityForCoordinate:(CLLocation*)location city:(void(^)(NSString*))cityBlock ;
+(void)getCoordinateForCityName:(NSString*)city  cityLocation:(void(^)(CLLocation*))cityLocation;
@end
