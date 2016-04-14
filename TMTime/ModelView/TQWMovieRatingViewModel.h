//
//  TQWMovieRatingViewModel.h
//  TMTime
//
//  Created by tarena33 on 16/4/13.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TQWMovieRatingViewModel : NSObject
//view 类属性
- (NSUInteger)rowNumber;
- (NSString*)movieNameWith:(NSInteger)index ;
- (NSString*)movieDirectorWith:(NSInteger)index;
- (NSString*)movieImageURLStringWith:(NSInteger)index;
- (NSString*)movieBoxOfficeWith:(NSInteger)index;
- (NSString*)movieSummarizedWith:(NSInteger)index;
- (NSString*)movietheaterReleaseDateWith:(NSInteger)index;
//model 属性
- (void)getMovieRatingType:(MovieRatingType)type completeHandler:(void(^)(NSError *error))completeHandler;
@end
