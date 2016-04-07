//
//  TQWCityListViewModel.m
//  TMTime
//
//  Created by tarena33 on 16/4/7.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWCityListViewModel.h"
#import "TQWCities.h"
#import "TQWGetData.h"

@interface TQWCityListViewModel()

@property(nonatomic,strong)NSMutableArray<TQWCities*> *cityList;

@end


@implementation TQWCityListViewModel

#pragma mark - 懒加载
- (NSMutableArray<TQWCities *> *)cityList{
    
    if (!_cityList) {
        _cityList = [NSMutableArray arrayWithCapacity:26];
    }
    return _cityList;
}

#pragma mark - 视图相关方法
- (NSInteger)sectionNumber{
    return self.cityList.count;
}

- (NSInteger)rowNumberWithSection:(NSInteger)section{
    return self.cityList[section].cities.count;
}

- (NSString *)sectionHeadWithSection:(NSInteger)section{
    return self.cityList[section].title;
}

- (NSString *)cityNameWithIndexPath:(NSIndexPath *)indexPath{
    return self.cityList[indexPath.section].cities[indexPath.row];
}

- (NSArray<NSString *> *)sectionIndexTitles{
    NSMutableArray *tempMutableArray = [NSMutableArray arrayWithCapacity:27];
    for (TQWCities *cities in self.cityList) {
        [tempMutableArray addObject:cities.title];
    }
    return [tempMutableArray copy];
}
#pragma mark - 模型相关方法

-(void)getCityListCompleteHandler:(void (^)(NSError *))completeHandler{
    [TQWGetData getCitiesListCompleteHander:^(NSArray<TQWCities *>*cities, NSError *error) {
        [_cityList addObjectsFromArray:cities];
        completeHandler(error);
    }];
}

@end
