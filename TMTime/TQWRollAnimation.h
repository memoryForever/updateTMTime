//
//  TQWRollAnimation.h
//  TMtime
//
//  Created by tarena33 on 16/3/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TQWRollAnimationDelegate <NSObject>
-(void)rollAnimationCurrentClickImageIndex:(NSInteger)index;
@end

@interface TQWRollAnimation : UIViewController
+(instancetype)addScrollAnimationAtViwe:(UIView*)superView imageArray:(NSArray<UIImage*>*)imageArray;
@property(nonatomic,weak) id<TQWRollAnimationDelegate> delegate;
@end
