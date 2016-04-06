//
//  TQWMovieNews.h
//  TMTime
//
//  Created by 涂清文 on 16/4/1.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 定义新闻类型 **/
typedef NS_ENUM(NSUInteger ,movieNewType) {
    movieNewTypeNewMove = 0 ,
    movieNewTypeInbrief ,
    movieNewTypeNone ,
    movieNewTypeAtlas,
};


@class TQWMovieNews ;
@interface TQWMovieNewsList : NSObject
@property(nonatomic,strong) NSArray<TQWMovieNews*> * dataList;
@property(nonatomic,assign) NSInteger errorCode ;
@property(nonatomic,assign) NSInteger pageIndex ;
@property(nonatomic,assign) NSInteger pageSize ;
@property(nonatomic,assign) NSInteger retcount ;
@end


@interface TQWMovieNews : NSObject
@property(nonatomic,strong) NSString  *movieNewID ;
@property(nonatomic,strong) NSString  *movieNewTitle;
@property(nonatomic,strong) NSString  *movieNewImageURL;
@property(nonatomic,strong) NSString  *movieNewContents;
@property(nonatomic,strong) NSString  *movieNewDate;
@property(nonatomic,strong) NSArray *movieNewImageURLS;
@property(nonatomic,assign) NSUInteger movieImageCount;
@property(nonatomic,assign) movieNewType  moviewNewType;
@end
