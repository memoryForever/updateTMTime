//
//  TQWMainViewModel.m
//  TMTime
//
//  Created by 涂清文 on 16/4/4.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWMainViewModel.h"
#import "TQWDouBanInTheaters.h"
#import "TQWDouBanMovie.h"
#import "TQWGetData.h"
#import "TQWMovieNews.h"

#define perpageNumber 6
#define onceLoadingNumber 12
#define perpageNewNumber 20


@interface TQWMainViewModel()
@property(nonatomic ,strong)  NSMutableArray<TQWDouBanMovie*> *container ;
@property(nonatomic ,assign)  NSUInteger currentEndPageNumber ;
@property(nonatomic ,copy)    void(^updataCompleteHander)(NSError *error);

//tableview model 相关
@property(nonatomic ,strong)  NSMutableArray<TQWMovieNews*>* movieNewContainer;
@property(nonatomic, assign)  NSUInteger currentEndIndex;
@property(nonatomic ,copy)    void(^tableUpdataCompleteHander)(NSError *error);
@property(nonatomic, copy)    void(^tableStartUpdata)();
@end


@implementation TQWMainViewModel

#pragma  mark - 懒加载
- (NSMutableArray<TQWDouBanMovie *> *)container{
    
    if (!_container) {
        _container  = [NSMutableArray array];
    }
    return _container;
}

- (NSMutableArray<TQWMovieNews *> *)movieNewContainer{
    if (!_movieNewContainer) {
        _movieNewContainer = [NSMutableArray array];
    }
    return _movieNewContainer ;
}

#pragma mark - 实例方法
-(instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSUInteger)itemNumber{
    
    return self.container.count ;
}

- (NSString *)movieTitleWithIndex:(NSUInteger)index{
    //执行预加载
    if (index > _container.count - 2 ) {
        if (_currentEndPageNumber != _container.count -1 ) {
            _currentEndPageNumber = _container.count - 1;
            [self getMovieInTheatersCompleteHandler:_updataCompleteHander];
        }
    }
    
    return self.container[index].title;
}

- (NSString *)movieRatingWithIndex:(NSUInteger)index{
    if (self.container[index].rating.average < 1 ) {
        return @"";
    }
    return  [NSString stringWithFormat:@"%.1f",self.container[index].rating.average];
}

- (NSString *)moviePosterWithIndex:(NSUInteger)index{
    return self.container[index].images.large;
}

#pragma mark - 电影消息相关的方法

- (NSUInteger)tableRowNumber{
    return self.movieNewContainer.count;
}

- (NSString *)movieNewTitle:(NSUInteger)index{
    //预加载
    if (index > self.movieNewContainer.count - 2 ) {
        if (_currentEndIndex == _movieNewContainer.count - 1 ) {
            [self getMovieNewRefershType:RefershTypeDown startUpdata:_tableStartUpdata CompleteHandler:_tableUpdataCompleteHander];
        }
    }
    return self.movieNewContainer[index].movieNewTitle;
}

- (NSString *)movieNewContent:(NSInteger)index{
    return self.movieNewContainer[index].movieNewContents;
}

- (NSUInteger)movieNewType:(NSInteger)index{
    return self.movieNewContainer[index].moviewNewType;
}

- (NSString *)movieNewImage:(NSInteger)index{
    return self.movieNewContainer[index].movieNewImageURL;
}

- (NSString *)movieNewLeftImage:(NSInteger)index{
    return self.movieNewContainer[index].movieNewImageURLS[0];
}

- (NSString *)movieNewCenterImage:(NSInteger)index{
    return self.movieNewContainer[index].movieNewImageURLS[1];
}

- (NSString *)movieNewRightImage:(NSInteger)index{
    return self.movieNewContainer[index].movieNewImageURLS[2];
}

#pragma  mark - 获取数据
- (void)getMovieInTheatersCompleteHandler:(void (^)(NSError *))completeHandler{
    [TQWGetData getInTheatersMoviesCity:kCurrentCityNameValue start:_currentEndPageNumber count:perpageNumber completeHandler:^(TQWDouBanInTheaters *theraters, NSError *error) {
        [self.container addObjectsFromArray:theraters.subjects];
        completeHandler(error);
        _updataCompleteHander = completeHandler;
    }];
}

- (void)refreshMovieInTheaters{
    [self.container removeAllObjects];
    _currentEndPageNumber = 0 ;
    [self getMovieInTheatersCompleteHandler:_updataCompleteHander];
}

- (void)getMovieNewRefershType:(RefershType)type startUpdata:(void(^)())startUpdata CompleteHandler:(void (^)(NSError *))competeHander {
    if (startUpdata) {
        startUpdata();
        _tableStartUpdata = startUpdata;
    }
    if (type == RefershTypeUp) {
        [_movieNewContainer removeAllObjects];
        _currentEndIndex = 0 ;
    }
    if (type == RefershTypeDown ) {
        _currentEndIndex = self.movieNewContainer.count ;
        NSLog(@"_currentEndIndex : %ld",_currentEndIndex);
    }
    [TQWGetData getMovieNewsListStart:_currentEndIndex count:perpageNewNumber completeHandler:^(TQWMovieNewsList *movieNewsList, NSError *error) {
        [_movieNewContainer addObjectsFromArray:movieNewsList.dataList];
        competeHander(error);
        _tableUpdataCompleteHander = competeHander;
    }];
}

#pragma mark - selector 相关方法


#pragma mark - 生命周期方法

- (void)dealloc{
    //移除所有监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark - 类方法




@end
