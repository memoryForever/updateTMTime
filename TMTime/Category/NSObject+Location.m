//
//  NSObject+Location.m
//  TMTime
//
//  Created by 涂清文 on 16/4/7.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "NSObject+Location.h"
#import <MapKit/MapKit.h>
#import <objc/runtime.h>


@implementation NSObject (Location)
//利用运行时给分类添加关联属性
-(void)setLocationManger:(CLLocationManager *)locationManger{
    return objc_setAssociatedObject(self, @selector(locationManger), locationManger, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CLLocationManager *)locationManger{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)confirmCurrentCity{
    CLLocationManager *manage = [[CLLocationManager alloc]init];
    self.locationManger       = manage ;
    manage.delegate           = self;
    //iOS 8 及以上进入
    if ([manage respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [manage requestWhenInUseAuthorization];
    }
    [manage startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (locations.count != 0) {
        manager.delegate = nil ;
        [manager stopUpdatingLocation];
    }
    
    CLLocation *location = [locations firstObject];
    [[[CLGeocoder alloc]init] reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"地址反编码错误:%@",error);
        }
        CLPlacemark *placemark = [placemarks firstObject];
        NSString  *positionCity = [placemark.addressDictionary[@"City"] stringByReplacingOccurrencesOfString:@"市" withString:@""];
        if ([self respondsToSelector:@selector(getCurrentCityNameCompleteHandler:)]) {
            [self getCurrentCityNameCompleteHandler:positionCity];
        }
    }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"获取位置失败%@",error);
}

@end


