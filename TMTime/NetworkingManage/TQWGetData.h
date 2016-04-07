//
//  TQWGetData.h
//  TMTime
//
//  Created by 涂清文 on 16/4/1.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TQWMovieNewsList,TQWDouBanMovie,TQWDouBanInTheaters,TQWDouBanSeacrchMovie,TQWDBRequestFindBussiness,TQWDBReques,TQWFindBussinessRespond,TQWDPRating ,TQWCities;
@interface TQWGetData : NSObject
+(void)getMovieNewsList:(NSString*)URLStr params:(NSDictionary*)params completeHandler:(void(^)(TQWMovieNewsList *movieNewsList,NSError *error)) completeHandler;
/**
 *  获取电影新闻消息
 *
 *  @param index           开始页
 *  @param count           本次获取消息的条数
 *  @param completeHandler 获取完成时调用的block
 */
+ (void)getMovieNewsListStart:(NSUInteger)index count:(NSUInteger)count completeHandler:(void(^)(TQWMovieNewsList *movieNewsList,NSError *error)) completeHandler;
/**
 *  根据电影ID获取电影详细
 *
 *  @param movieID         电影ID
 *  @param completeHandler 获取完成后调用block
 */
+ (void)getMovieInfoMovieID:(NSString*)movieID completeHandler:(void(^)(TQWDouBanMovie* movie, NSError *error)) completeHandler;
/**
 *  获取该城市正在上映的电影
 *
 *  @param cityName        城市名
 *  @param index           开始下标 从零开始
 *  @param count           本次获取的个数
 *  @param completeHandler 完成后调用block
 */
+ (void)getInTheatersMoviesCity:(NSString*)cityName start:(NSUInteger)index count:(NSUInteger)count completeHandler:(void(^)(TQWDouBanInTheaters *theraters,NSError *error)) completeHandler;
/**
 *  根据关键字或电影类型搜索电影
 *
 *  @param keywords       关键字
 *  @param type           类型
 *  @param index          开始下标,0开始
 *  @param count          返回的电影数目,最多20 条
 *  @param completeHander 搜索完成时调用
 */
+ (void)getMovieSearchCondition:(NSString*)keywords movieType:(NSString*)type respondStart:(NSUInteger)index count:(NSUInteger)count completeHandler:(void(^)(TQWDouBanSeacrchMovie* respondMovieList , NSError *error)) completeHander ;
/**
 *  获取北美前250 的电影条目
 *
 *  @param index 开始下标
 *  @param count 本次获取的数目
 */
+ (void)getNorthAmericaBefore250MoviesStart:(NSUInteger)index count:(NSUInteger)count completeHandler:(void(^)(TQWDouBanSeacrchMovie* respondMovieList , NSError *error)) completeHander;
/**
 *  获取将要上映的影片
 *
 *  @param cityName       所在城市
 *  @param index          开始下标
 *  @param count          获取的数量
 *  @param completeHander 获取成后调用block
 */
+ (void)getComingSoonMoviesCity:(NSString*)cityName start:(NSUInteger)index count:(NSUInteger)count completeHandler:(void(^)(TQWDouBanMovie *ComingSoonMovies,NSError *error)) completeHander;
/**
 *  北美票房榜
 *
 *  @param index          开始下标
 *  @param count          获取数量
 *  @param completeHander 获取成功后调用
 */
+ (void)getUSBoxStart:(NSUInteger)index count:(NSUInteger)count completeHandler:(void(^)(TQWDouBanMovie *ComingSoonMovies,NSError *error)) completeHander;
/**
 *  搜索点评网的商户数据
 *
 *  @param requestFindBussiness 请求参数描述
 *  @param completeHandler      获取成功后调用
 */
+ (void)getDiPinBussiness:(TQWDBRequestFindBussiness *)requestFindBussiness completeHandler:(void(^)(TQWFindBussinessRespond *bussinessRespond ,NSError *error)) completeHandler;
/**
 *  搜索指定商户的评价,最多3条,默认返回3条
 *
 *  @param BussinessID     商户ID
 *  @param completeHandler 获取成功后调用
 */
+ (void)getDiPinBussinessRating:(NSInteger)BussinessID completeHander:(void(^)(TQWDPRating *rating,NSError *error)) completeHandler;
/**
 *  获取城市列表
 *
 *  @param completeHandler 获取成功后调用
 */
+ (void)getCitiesListCompleteHander:(void(^)(NSArray<TQWCities *>*cities ,NSError *error)) completeHandler;
@end
