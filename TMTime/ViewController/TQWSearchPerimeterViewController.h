//
//  TQWSearchPerimeterViewController.h
//  TMTime
//
//  Created by tarena33 on 16/4/12.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQWSearchPerimeterViewController : UIViewController
//block 属性
@property(nonatomic,copy) void(^backBlock)(BussinessType ,NSString*);
@end
