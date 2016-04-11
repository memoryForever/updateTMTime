//
//  NSObject+LocationV2.m
//  TMTime
//
//  Created by tarena33 on 16/4/9.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "NSObject+LocationV2.h"
#import <objc/runtime.h>
#import <CoreLocation/CoreLocation.h>
 

@implementation NSObject (LocationV2) 

#pragma mark - 添加必要的属性

- (void)setTQWLocationManager:(CLLocationManager *)TQWLocationManager{
    objc_setAssociatedObject(self, @selector(TQWLocationManager), TQWLocationManager,  OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CLLocationManager *)TQWLocationManager{
   
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTQWGetLocationCompleterHandler:(TQW_Location_Block)TQWGetLocationCompleterHandler{
    objc_setAssociatedObject(self, @selector(TQWGetLocationCompleterHandler), TQWGetLocationCompleterHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (TQW_Location_Block)TQWGetLocationCompleterHandler{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTQWGeocoder:(CLGeocoder *)TQWGeocoder{
    objc_setAssociatedObject(self, @selector(TQWGeocoder), TQWGeocoder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CLGeocoder *)TQWGeocoder{
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - 加载属性值
- (void) loadPropertyValue{
    if (!self.TQWLocationManager) {
        self.TQWLocationManager = [[CLLocationManager alloc]init];
        if ([self.TQWLocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            //iOS 8 及以上
            [self.TQWLocationManager requestWhenInUseAuthorization];
        }
    }
    if (!self.TQWGeocoder) {
        self.TQWGeocoder = [CLGeocoder new];
    }
}


#pragma mark -  实现工具方法
- (void)TQWLocationManagerDidGetCurrentLocationCoordinateCompleteHandler:(void (^)(CLLocationCoordinate2D, NSError *))CompleteHandler{
    [self loadPropertyValue];
     self.TQWLocationManager.delegate = self;
//    if (![self.TQWLocationManager locationServicesEnabled]) {
//        NSError *error = [NSError errorWithDomain:@"定位服务未开启" code:kNotLocatinServer userInfo:nil];
//        CompleteHandler(CLLocationCoordinate2DMake(0, 0),error);
//        return ;
//    }
   
    [self.TQWLocationManager startUpdatingLocation];
    self.TQWGetLocationCompleterHandler = CompleteHandler;
}

- (void)TQWLocationManagerDidGetCurrentCityNameCompleteHandler:(void (^)(NSString *, NSError *))CompleteHander{
    [self loadPropertyValue];
    kWeakSelf(mySelf);
    [mySelf TQWLocationManagerDidGetCurrentLocationCoordinateCompleteHandler:^(CLLocationCoordinate2D coordinate2D, NSError *error) {
        [mySelf.TQWGeocoder reverseGeocodeLocation:[[CLLocation alloc]initWithLatitude:coordinate2D.latitude longitude:coordinate2D.longitude] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *placekmark = [placemarks firstObject];
            NSString* cityName = [placekmark.addressDictionary[@"City"] stringByReplacingOccurrencesOfString:@"市" withString:@""];
            CompleteHander(cityName,error);
        } ];
    }];
}
- (void)TQWLocationManagerGetCurrentDetailLocationInfoCompletereHandler:(void (^)(CLPlacemark *,NSError*))CompleteHandler{
    [self loadPropertyValue];
    kWeakSelf(mySelf);
    [self TQWLocationManagerDidGetCurrentLocationCoordinateCompleteHandler:^(CLLocationCoordinate2D coordinate2D, NSError *error) {
        [mySelf.TQWGeocoder reverseGeocodeLocation:[[CLLocation alloc]initWithLatitude:coordinate2D.latitude longitude:coordinate2D.longitude] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *placekmark = [placemarks firstObject];
            CompleteHandler(placekmark,error);
        } ];
    }];
}

- (void)TQWLocationManagerCoordinate2D:(CLLocationCoordinate2D)coordinate2D ReverseGeocodingCompleteHandler:(void (^)(CLPlacemark *, NSError *))CompleteHandler{
    [self loadPropertyValue];
    [self.TQWGeocoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:coordinate2D.latitude longitude:coordinate2D.longitude] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CompleteHandler(placemarks.firstObject,error);
    }];
}

- (void)TQWLocationManagerAddress:(NSString *)address ConvertGeocodingCompleteHandler:(void (^)(CLLocation *,NSError *error))CompleteHandler{
    [self loadPropertyValue];
    [self.TQWGeocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLLocation *location = [[placemarks firstObject] location];
        CompleteHandler(location,error);
    }];
}

#pragma mark - locationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (locations.count) {
        [self.TQWLocationManager stopUpdatingLocation];
        self.TQWLocationManager.delegate = nil;
    }
    self.TQWGetLocationCompleterHandler([locations firstObject].coordinate ,nil);
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"-- 位置获取失败 -- %@",error);
    self.TQWGetLocationCompleterHandler(kCoordinate2DOrigin,error);
}

@end
