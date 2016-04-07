//
//  TQWMainViewModel.h
//  TMTime
//
//  Created by 涂清文 on 16/4/4.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger ,RefershType) {
    RefershTypeUp,
    RefershTypeDown,
};

@interface TQWMainViewModel : NSObject
/** collection view 相关的属性 **/
- (NSUInteger) itemNumber;
- (NSString *) movieTitleWithIndex:(NSUInteger)index ;
- (NSString *) movieRatingWithIndex:(NSUInteger)index ;
- (NSString *) moviePosterWithIndex:(NSUInteger)index ;

/** tableView 相关的属性 **/
- (NSUInteger)tableRowNumber;
- (NSString*) movieNewTitle:(NSUInteger)index ;
- (NSUInteger)movieNewType:(NSInteger)index ;
- (NSString*) movieNewContent:(NSInteger)index;
- (NSString*) movieNewImage:(NSInteger)index;
- (NSString*) movieNewLeftImage:(NSInteger)index;
- (NSString*) movieNewCenterImage:(NSInteger)index;
- (NSString*) movieNewRightImage:(NSInteger)index;

/** model 相关的属性 **/
- (void)getMovieInTheatersCompleteHandler:(void(^)(NSError *error))completeHandler;
- (void)getMovieNewRefershType:(RefershType)type startUpdata:(void(^)())startUpdata CompleteHandler:(void(^)(NSError *error))competeHander;
- (void)refreshMovieInTheaters;
@end
