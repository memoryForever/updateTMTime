//
//  TQWShowPagesViewController.h
//  TMTime
//
//  Created by tarena33 on 16/4/19.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQWShowPagesViewController : UIViewController
@property (nonatomic,strong) NSMutableArray<UIImage*> *imageContainer;
- (void)showDetailContent:(NSString*)content imageURLStrs:(NSArray<NSString*>*)imageURLStrs;
@end
