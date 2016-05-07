//
//  TQWMainMainViewController.m
//  TMTime
//
//  Created by tarena33 on 16/4/22.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWMainMainViewController.h"

@implementation TQWMainMainViewController
- (void)viewDidLoad{
    [super viewDidLoad];
   
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
@end
