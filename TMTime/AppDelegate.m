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
    [self setupCurrentCity];
    [self setupGolbalNavigation];
    return YES;
}
- (void)setupGolbalNavigation{
    //间接设在状态栏为白色
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"menu_top_bg7"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}


@end
