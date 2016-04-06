//
//  TQWGetData.m
//  TMTime
//
//  Created by 涂清文 on 16/4/1.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWGetData.h"
#import <AFNetworking/AFNetworking.h>
#import <NSObject+YYModel.h>
#import "TQWMovieNews.h"
#import "NSObject+Parser.h"
#import "constant.h"
#import "TQWDouBanMovie.h"
#import "TQWDouBanInTheaters.h"
#import "TQWDouBanSeacrchMovie.h"
#import "TQWDouBanMovieUSBox.h"
#import "TQWDBRequestFindBussiness.h"
#import "TQWFindBussinessRespond.h"
#import "DPRequest.h"
#import "TQWDPRating.h"
#import "TQWCities.h"

@implementation TQWGetData
+(void)getMovieNewsList:(NSString *)URLStr params:(NSDictionary *)params completeHandler:(void (^)(TQWMovieNewsList *, NSError *))completeHandler{
    [self parserData:URLStr params:params modelClass:[TQWMovieNewsList class] completeHandler:^(id repondObject, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
           completeHandler(repondObject,error);
        });
        
    }];
}
+(void)getMovieNewsListStart:(NSUInteger)index count:(NSUInteger)count completeHandler:(void (^)(TQWMovieNewsList *, NSError *))completeHandler{
    NSString *urlStr = @"http://www.finndy.com/api.php";
    NSDictionary *params = @{
                                 @"pagesize" : @(count) ,
                                 @"pageindex" : @(index),
                                 @"datatype" : @"json",
                                 @"sortby" : @"desc",
                                 @"token" :kQIYUANTOKEN,
                                 };
    [self GET:urlStr params:params completeHandler:^(id respondObject, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completeHandler([TQWMovieNewsList parserJson:respondObject],error);
        });
    }];
}

+ (void)getMovieInfoMovieID:(NSString *)movieID completeHandler:(void (^)(TQWDouBanMovie *, NSError *))completeHandler{
    NSString *URLStr = kDOUBANMOVI_SUBJECT;
    URLStr = [URLStr stringByAppendingPathComponent:movieID];
    NSLog(@"%@",URLStr);
    
    [self GET:URLStr params:nil completeHandler:^(id respondObject, NSError *error) {
       dispatch_async(dispatch_get_main_queue(), ^{
           completeHandler([TQWDouBanMovie  parserJson:respondObject],error);
       });
    }];
}

+ (void)getInTheatersMoviesCity:(NSString *)cityName start:(NSUInteger)index count:(NSUInteger)count completeHandler:(void (^)(TQWDouBanInTheaters *, NSError *))completeHandler{
    NSString *URLStr = kDOUBANMOVI_InTheaters ;
    NSDictionary *params = @{
                             @"city":cityName ,
                             @"start":@(index),
                             @"count":@(count),
                             };
    [self GET:URLStr params:params completeHandler:^(id respondObject, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
              completeHandler([TQWDouBanInTheaters parserJson:respondObject],error);
        });
    }];
}

+ (void)getMovieSearchCondition:(NSString *)keywords movieType:(NSString *)type respondStart:(NSUInteger)index count:(NSUInteger)count completeHandler:(void (^)(TQWDouBanSeacrchMovie *, NSError *))completeHander{
    NSString *URLStr = kDOUBANMOVI_Searsh ;
    NSDictionary *params = @{
                             @"q":keywords,
                             @"tag":type,
                             @"start":@(index),
                             @"count":@(count),
                             };
    [self GET:URLStr params:params completeHandler:^(id respondObject, NSError *error) {
       dispatch_async(dispatch_get_main_queue(), ^{
           completeHander([TQWDouBanSeacrchMovie parserJson:respondObject],error);
       });
    }];
}

+ (void)getNorthAmericaBefore250MoviesStart:(NSUInteger )index count:(NSUInteger )count completeHandler:(void(^)(TQWDouBanSeacrchMovie* respondMovieList , NSError *error)) completeHander{
    NSString *URLStr = kDOUBANMOVI_250 ;
    NSDictionary *params = @{
                             @"start":@(index),
                             @"count":@(count),
                           };
    [self GET:URLStr params:params completeHandler:^(id respondObject, NSError *error) {
       dispatch_async(dispatch_get_main_queue(), ^{
           completeHander([TQWDouBanSeacrchMovie parserJson:respondObject],error);
       });
    }];
}

+ (void)getComingSoonMoviesCity:(NSString *)cityName start:(NSUInteger)index count:(NSUInteger)count completeHandler:(void (^)(TQWDouBanMovie *, NSError *))completeHander{
    NSString *URLStr = kDOUBANMOVI_ComingSoon ;
    NSDictionary *params = @{
                             @"city":cityName,
                             @"start":@(index),
                             @"count":@(count),
                             };
    [self GET:URLStr params:params completeHandler:^(id respondObject, NSError *error) {
       dispatch_async(dispatch_get_main_queue(), ^{
           completeHander([TQWDouBanSeacrchMovie parserJson:respondObject],error);
       });
    }];
}
+ (void)getUSBoxStart:(NSUInteger)index count:(NSUInteger)count completeHandler:(void (^)(TQWDouBanMovie *, NSError *))completeHander{
    NSString *URLStr = kDOUBANMOVI_USBox ;
    NSDictionary *params = @{
                             @"start":@(index),
                             @"count":@(count),
                             };
    
    [self GET:URLStr params:params completeHandler:^(id respondObject, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completeHander([TQWDouBanMovieUSBox parserJson:respondObject],error);
        });
    }];
}
+ (void)getDiPinBussiness:(TQWDBRequestFindBussiness *)requestFindBussiness completeHandler:(void (^)(TQWFindBussinessRespond *, NSError *))completeHandler{
    [self GET:[DPRequest  requestWithURL:kDPSubDomain params:[requestFindBussiness getParams]] params:nil completeHandler:^(id respondObject, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completeHandler([TQWFindBussinessRespond parserJson:respondObject],error);
        });
    }];
}

+ (void)getDiPinBussinessRating:(NSInteger)BussinessID completeHander:(void (^)(TQWDPRating *, NSError *))completeHandler{
    [self GET:[DPRequest requestWithURL:kDPSubDomain_rating params:@{@"business_id":@(BussinessID)}] params:nil completeHandler:^(id respondObject, NSError *error) {
       dispatch_async(dispatch_get_main_queue(), ^{
            completeHandler( [TQWDPRating parserJson:respondObject],error);
       });
    }];
}

+ (void)getCitiesListCompleteHander:(void (^)(TQWCities *, NSError *))completeHandler{
    [self read:kPListCityGroups completeHandler:^(id respondObject, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completeHandler([TQWCities parserJson:respondObject],error);
        });
    }];
}
@end
