//
//  AppDelegate.m
//  TMTime
//
//  Created by 涂清文 on 16/3/31.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+System.h"
#import "ViewController.h"
#import "TQWGetData.h"
#import "AppDelegate+Location.h"


@interface AppDelegate ()

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self confirmCurrentCity];
    
    return YES;
}



@end
