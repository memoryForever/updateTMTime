//
//  UIScrollView+Refersh.h
//  TMTime
//
//  Created by 涂清文 on 16/4/1.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Refersh)
- (void)addHeadRefersh:(void(^)())block;
- (void)beginHeadRefersh;
- (void)endedHeadRefersh;
- (void)endedHeadRefersh:(void(^)())block;
- (void)addFooterRefersh:(void(^)())block;
- (void)beginFooterRefersh;
- (void)endedFooterRefersh;
- (void)endedFooterRefersh:(void(^)())block;
- (void)addHeadRefershAnimation:(void(^)())block ;
- (void)addFooterRefershAnimation:(void (^)())block;
@end

