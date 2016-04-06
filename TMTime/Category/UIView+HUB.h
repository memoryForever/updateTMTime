//
//  UIView+HUB.h
//  TMTime
//
//  Created by 涂清文 on 16/4/1.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HUB)
-(void)showSuccess:(NSString*)prompt;
-(void)showFailure:(NSString*)prompt;
-(void)showDosomething:(NSString*)prompt ;
-(void)showWarning:(NSString*)prompt;
-(void)hidePromptView ;
@end
