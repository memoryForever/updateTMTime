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
#import "TQWGetData.h"
#import "TQWDouBanMovieUSBox.h"

//test


@interface AppDelegate ()

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self setupCurrentCity];
    [self setupGolbalNavigation];
    //设置默认城市
    [self defaultCityName];
    return YES;
}
- (void)setupGolbalNavigation{
    //间接设在状态栏为白色
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"menu_top_bg7"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}
/** 截取请求 test*/
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    NSLog(@"%@",url.absoluteString );
//    //获取导航控制器
//    UINavigationController *navi = (UINavigationController*)self.window.rootViewController;
//    //主界面控制器
//    UIViewController *mainVc = (UIViewController*)navi.topViewController;
//    NSString *urlString = [url.absoluteString componentsSeparatedByString:@"?"].lastObject;
//    if ([urlString isEqualToString:@"detailPage"]) {
//        
//    }
//    return YES;
//}




- (void)defaultCityName{
    if (!kCurrentCityNameValue) {
        kSaveCurrentCityName(@"北京");
    }
}

@end
