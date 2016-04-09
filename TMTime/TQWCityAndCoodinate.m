//
//  TQWCityAndCoodinate.m
//  天气APP
//
//  Created by tarena33 on 16/3/24.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TQWCityAndCoodinate.h"


@interface TQWCityAndCoodinate()<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *manager;
@property(nonatomic,strong)CLLocation *location;
@property(nonatomic,strong)CLGeocoder *geocoder;
@property(nonatomic,assign)CLLocation* cityCoordinate;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)void(^currentCityName)(NSString*);
@property(nonatomic,copy)void(^currentCityLocation)(CLLocation*);
@property(nonatomic,copy)void(^cityName)(NSString*);
@property(nonatomic,copy)void(^cityLocation)(CLLocation*);
@end

static TQWCityAndCoodinate *shareObject;
@implementation TQWCityAndCoodinate
+(instancetype)shareCityAndCoodinate{
    if (!shareObject ) {
        shareObject = [[TQWCityAndCoodinate alloc]init];
        shareObject.manager = [[CLLocationManager alloc]init];
        shareObject.manager.delegate = shareObject;
        [shareObject.manager requestWhenInUseAuthorization];
        shareObject.geocoder = [[CLGeocoder alloc]init];
    }
    return shareObject;
}

+(void)getCurrentCoordinate:(void (^)(CLLocation *))currentLocationBlock{
    shareObject = [TQWCityAndCoodinate shareCityAndCoodinate];
    [shareObject.manager requestLocation];
    shareObject.currentCityLocation = currentLocationBlock  ;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
     shareObject.currentCityLocation(locations.lastObject);
}
+(void)getCoordinateForCityName:(NSString *)city cityLocation:(void (^)(CLLocation *))cityLocation{
    [shareObject.geocoder geocodeAddressString:city completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
         cityLocation(placemarks[0].location);
    }];
}
+(void)getCityForCoordinate:(CLLocation *)location city:(void (^)(NSString *))cityBlock{
    [shareObject.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        cityBlock(placemarks.firstObject.name);
    }];
}
+(void)getCurrentCity:(void (^)(NSString *))currentLocationCityBlock{
    [TQWCityAndCoodinate getCurrentCoordinate:^(CLLocation *location) {
        [TQWCityAndCoodinate getCityForCoordinate:location city:^(NSString *city) {
            currentLocationCityBlock(city);
        }];
    }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    static int count = 0 ;
    count ++ ;
    if (count < 10 ) {
        NSLog(@"%@",error);
       [shareObject.manager requestLocation];
    }
}
@end
