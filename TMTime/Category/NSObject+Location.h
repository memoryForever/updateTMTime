//
//  NSObject+Location.h
//  TMTime
//
//  Created by 涂清文 on 16/4/7.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol selfDelegateProtocol  <NSObject>
@optional
- (void) getCurrentCityNameCompleteHandler:(NSString *)cityName;
@end

@interface NSObject (Location)<CLLocationManagerDelegate,selfDelegateProtocol>
@property(nonatomic,strong) CLLocationManager *locationManger ;
/** 确认当城市 **/
- (void)confirmCurrentCity;

@end
