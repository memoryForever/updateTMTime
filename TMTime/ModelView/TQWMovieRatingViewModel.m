//
//  TQWMovieRatingViewModel.m
//  TMTime
//
//  Created by tarena33 on 16/4/13.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWMovieRatingViewModel.h"
#import "TQWGetData.h"
#import "TQWDouBanInTheaters.h"
#import "TQWDouBanMovieUSBox.h"
#import "TQWDouBanMovie.h"
#import "TQWDouBanSeacrchMovie.h"

#define kPerpageNumber 10

@interface TQWMovieRatingViewModel()
//存储属性
@property (nonatomic,strong) NSMutableArray<TQWDouBanMovie*> *movieContainter;
@property (nonatomic,strong) NSMutableArray<TQWUSBoxSubjects*> *movieBoxSubjects;
@property (nonatomic,assign) NSUInteger endIndex ;
@property (nonatomic,copy) void (^loadingDataCompleterHandler)(NSError *);
@property (nonatomic,assign) MovieRatingType currentType ;
@end



@implementation TQWMovieRatingViewModel

#pragma mark - 懒加载

- (NSMutableArray<TQWDouBanMovie *> *)movieContainter{
    if (!_movieContainter) {
        _movieContainter = [NSMutableArray array];
    }
    return _movieContainter;
}
- (NSMutableArray<TQWUSBoxSubjects *> *)movieBoxSubjects{
    if (!_movieBoxSubjects) {
        _movieBoxSubjects = [NSMutableArray array];
    }
    return _movieBoxSubjects ;
}

#pragma mark -  view相关方法实现
- (NSUInteger)rowNumber{
    if (_currentType == MovieRatingTypeNorthernAmericaBox) {
        return self.movieBoxSubjects.count  ;
    }
    return self.movieContainter.count;
}
- (NSString *)movieNameWith:(NSInteger)index{
    if (index != 0 && index != _endIndex &&index > _endIndex - 3 ) {
        if (_currentType == MovieRatingTypeNorthernAmericaBox) {
            _endIndex = _movieBoxSubjects.count;
        }else {
          _endIndex = _movieContainter.count - 1;
        }
        if (_loadingDataCompleterHandler) {
            [self getMovieRatingType:_currentType completeHandler:_loadingDataCompleterHandler];
        }
    }
    if (_currentType == MovieRatingTypeNorthernAmericaBox) {
        return self.movieBoxSubjects[index].subject.title;
    }
    return self.movieContainter[index].title;
}

- (NSString *)movieDirectorWith:(NSInteger)index{
    if (_currentType == MovieRatingTypeNorthernAmericaBox) {
        return self.movieBoxSubjects[index].subject.title;
    }
    return self.movieContainter[index].directors.firstObject.name;
}

- (NSString *)movieImageURLStringWith:(NSInteger)index{
    if (_currentType == MovieRatingTypeNorthernAmericaBox) {
        return self.movieBoxSubjects[index].subject.images.large;
    }
    return self.movieContainter[index].images.large;
}

- (NSString *)movieBoxOfficeWith:(NSInteger)index{
    if (_currentType == MovieRatingTypeNorthernAmericaBox) {
        return  [NSString stringWithFormat:@"票房:%ld",self.movieBoxSubjects[index].box];
    }
    return  @"1000";
}

- (NSString *)movieSummarizedWith:(NSInteger)index{
    if (_currentType == MovieRatingTypeNorthernAmericaBox) {
        return @"简介";
    }
    return self.movieContainter[index].summary;
}
- (NSString *)movietheaterReleaseDateWith:(NSInteger)index{
    if (_currentType == MovieRatingTypeNorthernAmericaBox) {
        return self.movieBoxSubjects[index].subject.year;
    }
    return self.movieContainter[index].year;
}

#pragma mark - model 相关方法

- (void)getMovieRatingType:(MovieRatingType)type completeHandler:(void (^)(NSError *))completeHandler{
    _loadingDataCompleterHandler = completeHandler;
     _currentType = type;
    kWeakSelf(mySelf);
    if (MovieRatingType250 == type) {
        [TQWGetData getNorthAmericaBefore250MoviesStart:_endIndex count:kPerpageNumber completeHandler:^(TQWDouBanSeacrchMovie *respondMovieList, NSError *error) {
            [mySelf.movieContainter addObjectsFromArray:respondMovieList.subjects];
            completeHandler(error);
            
            _endIndex = _movieContainter.count;
        }];
    }
    if (MovieRatingTypeNorthernAmericaBox == type) {
        [TQWGetData getUSBoxStart:_endIndex count:kPerpageNumber completeHandler:^(TQWDouBanMovieUSBox*ComingSoonMovies, NSError *error) {
            [mySelf.movieBoxSubjects addObjectsFromArray:ComingSoonMovies.subjects];
            _endIndex = _movieBoxSubjects.count;
            completeHandler(error);
        }];
    }
}



#pragma mark - 私有实例方法


@end
