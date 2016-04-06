//
//  TQWDouBanSeacrchMovie.h
//  TMTime
//
//  Created by 涂清文 on 16/4/2.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TQWDouBanMovie;
@interface TQWDouBanSeacrchMovie : NSObject

@property (nonatomic, strong) NSArray<TQWDouBanMovie *> *subjects;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger start;

@end


