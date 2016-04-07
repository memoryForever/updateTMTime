//
//  AppDelegate+Location.m
//  TMTime
//
//  Created by tarena33 on 16/4/7.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "AppDelegate+Location.h"
#import <MapKit/MapKit.h>

@implementation AppDelegate (Location)
- (void)confirmCurrentCity{
    CLLocationManager *manage = [[CLLocationManager alloc]init];
    manage.delegate = self;
    if ([manage respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [manage requestWhenInUseAuthorization];
    }
}


@end
