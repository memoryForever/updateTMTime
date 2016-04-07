//
//  AppDelegate+Location.h
//  TMTime
//
//  Created by tarena33 on 16/4/7.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate (Location)<CLLocationManagerDelegate>
/** 确认当城市 **/
- (void)confirmCurrentCity;
@end
