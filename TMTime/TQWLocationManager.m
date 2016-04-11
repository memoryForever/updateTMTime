//
//  TQWLocationManager.m
//  TMTime
//
//  Created by tarena33 on 16/4/9.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWLocationManager.h"
#import "NSObject+LocationV2.h"


@implementation TQWLocationManager
static id _singleIntance = nil  ;
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t token ;
    dispatch_once(&token, ^{
        _singleIntance = [super allocWithZone:zone];
    });
    return _singleIntance;
}

- (instancetype)init{
    static dispatch_once_t token ;
    dispatch_once(&token, ^{
        _singleIntance = [super init];
    });
    return  _singleIntance;
}
+ (void)LocationManagerDidGetCurrentCityNameCompleteHandler:(void (^)(NSString *, NSError *))CompleteHander{
    [[TQWLocationManager new] TQWLocationManagerDidGetCurrentCityNameCompleteHandler:^(NSString *cityName, NSError *error) {
        CompleteHander(cityName,error);
    }];
}

+ (void)LocationManagerDidGetCurrentLocationCoordinateCompleteHandler:(void (^)(CLLocationCoordinate2D, NSError *))CompleteHandler{

        [[TQWLocationManager new]  TQWLocationManagerDidGetCurrentLocationCoordinateCompleteHandler:^(CLLocationCoordinate2D coordinate2D, NSError *error) {
            NSLog(@"current Thread : %@",[NSThread currentThread]);
            CompleteHandler(coordinate2D,error);
        }];
   
}
+ (void)LocationManagerCoordinate2D:(CLLocationCoordinate2D)coordinate2D ReverseGeocodingCompleteHandler:(void (^)(NSString *, NSError *))CompleteHandler{
     [[TQWLocationManager new] TQWLocationManagerCoordinate2D:coordinate2D ReverseGeocodingCompleteHandler:^(CLPlacemark *placemark, NSError *error) {
         NSString *cityName = [placemark.addressDictionary[@"City"] stringByReplacingOccurrencesOfString:@"市" withString:@""];
         CompleteHandler(cityName,error);
     }];
}

@end
