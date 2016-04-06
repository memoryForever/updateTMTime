//
//  UIScrollView+Refersh.m
//  TMTime
//
//  Created by 涂清文 on 16/4/1.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "UIScrollView+Refersh.h"

@implementation UIScrollView (Refersh)
-(void)addHeadRefersh:(void (^)())block{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        block();
    }];
}
-(void)beginHeadRefersh{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_header beginRefreshing];
    });
    
}
-(void)endedHeadRefersh{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_header endRefreshing];
    });
}
-(void)endedHeadRefersh:(void (^)())block{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_header endRefreshing];
        block();
    });
}
-(void)addFooterRefersh:(void (^)())block{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }];
}

-(void)beginFooterRefersh{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_footer beginRefreshing];
    });
}
-(void)endedFooterRefersh{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_footer endRefreshing];
    });
}
-(void)endedFooterRefersh:(void (^)())block{
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.mj_footer endRefreshing];
        block();
    });
}
-(void)addHeadRefershAnimation:(void (^)())block{
    self.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        block();
    }];
     MJRefreshGifHeader *head = (MJRefreshGifHeader*)self.mj_header;
    NSMutableArray<UIImage*> *images = [NSMutableArray arrayWithCapacity:26];
    for (NSInteger i = 0 ; i < 26; i ++) {
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading%04ld",i+1]]];
    }
    [head setImages:images duration:1 forState:MJRefreshStateRefreshing];
}
-(void)addFooterRefershAnimation:(void (^)())block{
    self.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        block();
    }];
    NSMutableArray<UIImage*> *images = [NSMutableArray arrayWithCapacity:26];
    for (NSInteger i = 0 ; i < 26; i ++) {
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading%04ld",i+1]]];
    }
    MJRefreshBackGifFooter *footer = (MJRefreshBackGifFooter*) self.mj_footer;
    [footer setImages:images duration:1 forState:MJRefreshStateRefreshing];
}
@end
