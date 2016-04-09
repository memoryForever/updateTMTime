//
//  AppDelegate+Location.m
//  TMTime
//
//  Created by tarena33 on 16/4/7.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "AppDelegate+Location.h"
#import "TQWLocationManager.h"

@implementation AppDelegate (Location)
////利用运行时给分类添加关联属性
//-(void)setLocationManger:(CLLocationManager *)locationManger{
//    return objc_setAssociatedObject(self, @selector(locationManger), locationManger, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//-(CLLocationManager *)locationManger{
//    return objc_getAssociatedObject(self, _cmd);
//}

- (void)setupCurrentCity{
//    CLLocationManager *manage = [[CLLocationManager alloc]init];
//    self.locationManger       = manage ;
//    manage.delegate           = self;
//    //iOS 8 及以上进入
//    if ([manage respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        [manage requestWhenInUseAuthorization];
//    }
//    [manage startUpdatingLocation];
    [TQWLocationManager LocationManagerDidGetCurrentCityNameCompleteHandler:^(NSString *cityName, NSError *error) {
            [self getCurrentCityNameCompleteHandler:cityName];
   
    }];
    
}
- (void)getCurrentCityNameCompleteHandler:(NSString *)cityName{
            if (!kCurrentCityNameValue) {
                kSaveCurrentCityName(cityName);
                return  ;
            }
            if (![kCurrentCityNameValue isEqualToString:cityName]) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"位置发生变化" message:[NSString stringWithFormat:@"是否从'%@'切换到'%@'?",kCurrentCityNameValue,cityName] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                UIAlertAction *change = [UIAlertAction actionWithTitle:@"切换" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    kSaveCurrentCityName(cityName);
                    [[NSNotificationCenter defaultCenter] postNotificationName:kCurrentCityChangeNotification object:self];
                }];
                [alertController addAction:cancel];
                [alertController addAction:change];
                [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
}
//
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
//    if (locations.count != 0) {
//        manager.delegate = nil ;
//       [manager stopUpdatingLocation];
//    }
//    
//    CLLocation *location = [locations firstObject];
//    [[[CLGeocoder alloc]init] reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"地址反编码错误:%@",error);
//        }
//        CLPlacemark *placemark = [placemarks firstObject];
//        NSString  *positionCity = [placemark.addressDictionary[@"City"] stringByReplacingOccurrencesOfString:@"市" withString:@""];
//        if (!kCurrentCityNameValue) {
//            kSaveCurrentCityName(positionCity);
//            return  ;
//        }
//        if (![kCurrentCityNameValue isEqualToString:positionCity]) {
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"位置发生变化" message:[NSString stringWithFormat:@"是否从'%@'切换到'%@'?",kCurrentCityNameValue,positionCity] preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//            UIAlertAction *change = [UIAlertAction actionWithTitle:@"切换" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                kSaveCurrentCityName(positionCity);
//                [[NSNotificationCenter defaultCenter] postNotificationName:kCurrentCityChangeNotification object:self];
//            }];
//            [alertController addAction:cancel];
//            [alertController addAction:change];
//            [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
//        }
//    }];
//}
//
//
//
//
//-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
//    NSLog(@"获取位置失败%@",error);
//}

@end
