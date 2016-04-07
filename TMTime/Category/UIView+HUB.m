//
//  UIView+HUB.m
//  TMTime
//
//  Created by 涂清文 on 16/4/1.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "UIView+HUB.h"

@implementation UIView (HUB)
-(void)showSuccess:(NSString *)prompt{
   // [self hidePromptView];
   MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hub.mode = MBProgressHUDModeText;
    hub.labelText = prompt;
    [hub hide:YES afterDelay:0.5];
}
-(void)showWarning:(NSString *)prompt{
   // [self hidePromptView];
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hub.mode = MBProgressHUDModeText;
    hub.labelText = prompt;
    hub.labelColor = [UIColor redColor];
    [hub hide:YES afterDelay:1];
}
-(void)showFailure:(NSString *)prompt{
 //   [self hidePromptView];
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hub.mode = MBProgressHUDModeText;
    hub.labelText = prompt;
    [hub hide:YES afterDelay:1];
}
-(void)hidePromptView{
    dispatch_async(dispatch_get_main_queue(), ^{
         [MBProgressHUD hideAllHUDsForView:self animated:YES];
    });
}

-(void)showDosomething:(NSString *)prompt{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hub.mode = MBProgressHUDModeIndeterminate;
    [hub hide:YES afterDelay:30];
}

@end
