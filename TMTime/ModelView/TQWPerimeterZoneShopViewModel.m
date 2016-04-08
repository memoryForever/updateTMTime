//
//  TQWPerimeterZoneShopViewModel.m
//  TMTime
//
//  Created by tarena33 on 16/4/8.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWPerimeterZoneShopViewModel.h"
#import "TQWFindBussinessRespond.h"
#import "TQWGetData.h"
#import "TQWDBRequestFindBussiness.h"
#import "NSObject+Location.h"

@interface TQWPerimeterZoneShopViewModel()
/** 保存获取到的商品 **/
@property (nonatomic,strong) NSMutableArray<TQWBusinesses*> *bussessContainer;

/** model 属性 **/

@property (nonatomic,strong) TQWDBRequestFindBussiness *requestFindBussiness;
/** 计算属性 **/
@property (nonatomic,assign) CLLocationCoordinate2D currentCoordinate ;
//私有方法

@end

@implementation TQWPerimeterZoneShopViewModel

#pragma mark - 懒加载

- (NSMutableArray<TQWBusinesses*> *)bussessContainer{
    if (!_bussessContainer) {
        _bussessContainer = [NSMutableArray array];
    }
    
    return _bussessContainer;
}

- (TQWDBRequestFindBussiness *)requestFindBussiness{
    if (!_requestFindBussiness) {
        TQWDBRequestFindBussiness *request = [[TQWDBRequestFindBussiness alloc]init];
        _requestFindBussiness = request ;
        request.latitude = _currentCoordinate.latitude;
        request.longitude = _currentCoordinate.longitude;
        request.city = kCurrentCityNameValue ;
        request.mapType = MapTypeGaoDe ;
        request.radius = 2000 ;
        request.category = kBussinessTypeFooder;
        request.page = 1 ;
        request.limitPaginalMaxBuessinesCount = 30 ;
        request.sortRule =  SortRuleNearby;
    }
    return _requestFindBussiness;
}
#pragma tableView 相关
- (NSUInteger)rowNumber
{
    return _bussessContainer.count;
}

- (NSString *)bussinessImageURLStringWithIndex:(NSUInteger)index{
    return self.bussessContainer[index].photo_url ;
}

- (NSString *)bussinessNameWithIndex:(NSUInteger)index{
    NSLog(@"111:%@",self.bussessContainer[index].name);
    return self.bussessContainer[index].name;
}

- (NSString *)bussinessPriceWthIndex:(NSUInteger)index{
    if (self.bussessContainer[index].avg_price == 0) {
        return @"免费";
    }
    return [NSString stringWithFormat:@"%ld",self.bussessContainer[index].avg_price];
}

- (NSString *)bussinessDistanceWithIndex:(NSInteger)index{
    return [NSString stringWithFormat:@"%ld",self.bussessContainer[index].distance];
}

- (NSString *)bussinessDisCountWithIndex:(NSInteger)index{
    return [NSString stringWithFormat:@"95"];
}

- (NSString *)bussinessReservationWithIndex:(NSInteger)index{
    if (!self.bussessContainer[index].has_online_reservation) {
        return @"";
    }
    return self.bussessContainer[index].online_reservation_url;
}
#pragma mark - 数据/模型 获取
- (void)getBussinessInfoCompleteHandler:(void (^)(NSError *))completeHandler{
    
   [TQWGetData getDiPinBussiness:self.requestFindBussiness completeHandler:^(TQWFindBussinessRespond *bussinessRespond, NSError *error) {
       
       [self.bussessContainer  addObjectsFromArray:bussinessRespond.businesses];
       completeHandler(error);
   }];
}

- (void)getCurrentCoordinate2D:(CLLocationCoordinate2D)coordinate{
    self.currentCoordinate = coordinate;
}


@end
