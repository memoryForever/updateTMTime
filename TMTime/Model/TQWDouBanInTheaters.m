//
//  TQWDouBanInTheaters.m
//  TMTime
//
//  Created by 涂清文 on 16/4/2.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWDouBanInTheaters.h"
#import "TQWDouBanMovie.h"

@implementation TQWDouBanInTheaters

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{
             @"subjects":[TQWDouBanMovie class],
             };
}
@end 


