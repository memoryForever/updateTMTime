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
#import "TQWLocationManager.h"
#import "TQWAnnotation.h"

#define kPrepageRowNumber 30
/** 预加载条件是倒数第5行开始 **/
#define kPrestrainCondition 5

@interface TQWPerimeterZoneShopViewModel()
/** 保存获取到的商品 **/
@property (nonatomic,strong) NSMutableArray<TQWBusinesses*> *bussessContainer;
/** model 属性 **/
@property (nonatomic,strong) TQWDBRequestFindBussiness *requestFindBussiness;
/** 存储属性 **/
/** 保存用户当前位置 **/
@property (nonatomic,assign) CLLocationCoordinate2D currentCoordinate ;
/** 保存当前城市 **/
@property (nonatomic ,strong) NSString *currentCity ;
/** 保存用户刷新操作 **/
@property (nonatomic,strong) void(^loadDataCompleteOperater)(NSError *error);
@property (nonatomic,assign) NSInteger currentPage;
//私有方法

@end

@implementation TQWPerimeterZoneShopViewModel

#pragma mark - 懒加载

- (NSMutableArray<TQWBusinesses*> *)bussessContainer{
    if (!_bussessContainer) {
        _bussessContainer = [NSMutableArray array];
        _currentPage = 1 ;
    }
    
    return _bussessContainer;
}

- (TQWDBRequestFindBussiness *)requestFindBussiness{
    if (!_requestFindBussiness) {
        TQWDBRequestFindBussiness *request = [[TQWDBRequestFindBussiness alloc]init];
        _requestFindBussiness = request ;
        request.mapType = MapTypeGaoDe ;
        request.radius = 5000 ;
        request.category = kBussinessTypeFooder;
        request.page = 1 ;
        request.limitPaginalMaxBuessinesCount = kPrepageRowNumber ;
        request.sortRule =  SortRuleNone;
    }
    return _requestFindBussiness;
}
#pragma mark - tableView 相关
- (NSUInteger)rowNumber
{
    return _bussessContainer.count;
}

- (NSString *)bussinessImageURLStringWithIndex:(NSUInteger)index{
    return self.bussessContainer[index].photo_url ;
}

- (NSString *)bussinessNameWithIndex:(NSUInteger)index{
    if ((self.bussessContainer.count != 0 )&& (index == self.bussessContainer.count - kPrestrainCondition) ) {
        [self prestrainFunction];
    }
    return self.bussessContainer[index].name;
}

- (NSString *)bussinessPriceWthIndex:(NSUInteger)index{
    if (self.bussessContainer[index].avg_price == 0) {
        return @"店询";
    }
    return [NSString stringWithFormat:@"%ld",self.bussessContainer[index].avg_price];
}

- (NSString *)bussinessDistanceWithIndex:(NSInteger)index{
    if (self.bussessContainer[index].distance == -1) {
        return self.requestFindBussiness.city;
    }
    return [NSString stringWithFormat:@"离我约%ld m",self.bussessContainer[index].distance];
}

- (NSString *)bussinessDisCountWithIndex:(NSInteger)index{
    //假数据,未捕获相关数据源
    return [NSString stringWithFormat:@"95折"];
}

- (NSString *)bussinessReservationWithIndex:(NSInteger)index{
    if (!self.bussessContainer[index].has_online_reservation) {
        return @"";
    }
    return self.bussessContainer[index].online_reservation_url;
}

#pragma mark - mapView
- (CLLocationCoordinate2D)bussinessCoordiate2DWithIndex:(NSInteger)index{
    return CLLocationCoordinate2DMake(self.bussessContainer[index].latitude, self.bussessContainer[index].longitude);
}

- (TQWAnnotation *)bussinessAnnotationWithIndex:(NSInteger)index{
    TQWAnnotation *ann = [[TQWAnnotation alloc]init];
    ann.title = [self bussinessNameWithIndex:index];
    ann.subtitle = self.bussessContainer[index].address;
    ann.URLImage = [self bussinessImageURLStringWithIndex:index];
    ann.coordinate = [self bussinessCoordiate2DWithIndex:index];
    return ann;
}

#pragma mark - 数据/模型 获取
- (void)getBussinessInfoCompleteHandler:(void (^)(NSError *))completeHandler{
    kWeakSelf(mySelf);
    _loadDataCompleteOperater = completeHandler;
    [TQWLocationManager LocationManagerDidGetCurrentLocationCoordinateCompleteHandler:^(CLLocationCoordinate2D coordinate2D, NSError *error) {
        if (error) {
            mySelf.requestFindBussiness.city = kCurrentCityNameValue;
            [mySelf loadData];
        }
        mySelf.requestFindBussiness.latitude = coordinate2D.latitude;
        mySelf.requestFindBussiness.longitude = coordinate2D.longitude;
        mySelf.currentCoordinate = coordinate2D;
        [TQWLocationManager LocationManagerCoordinate2D:coordinate2D ReverseGeocodingCompleteHandler:^(NSString *cityName, NSError *error) {
            if (_currentCity && [cityName isEqualToString:_currentCity]) {
            }else {
                if ( ![cityName isEqualToString:kCurrentCityNameValue]) {
                    mySelf.requestFindBussiness.city = kCurrentCityNameValue;
                    mySelf.currentCity = cityName;
                }
            }
        [TQWGetData getDiPinBussiness:mySelf.requestFindBussiness completeHandler:^(TQWFindBussinessRespond *bussinessRespond, NSError *error) {
                [mySelf.bussessContainer  addObjectsFromArray:bussinessRespond.businesses];
                completeHandler(error);
            }];
        }];
    }];
}

- (void)refershDataAndRefersh:(RefershType)type{
    if (type == RefershTypeCityChange || type == RefershTypePullUp) {
        [self.bussessContainer removeAllObjects];
        self.requestFindBussiness.page = 1 ;
        if (_loadDataCompleteOperater) {
            [self loadData];
        }
    }
    
    if (type == RefershTypeLoadModeData) {
    
        [self prestrainFunction];
    }
    if (type == RefershTypeRelocation) {
        if (![self.requestFindBussiness.city isEqualToString:self.currentCity]) {
            [self.bussessContainer removeAllObjects];
        }
        [self getBussinessInfoCompleteHandler:_loadDataCompleteOperater];
    }
   
}

- (void)bussinessSearchCategory:(BussinessType)type keyword:(NSString *)keyword{
    if (type != BussinessTypeNone) {
           self.requestFindBussiness.category = @[kBussinessTypeFooder,kBussinessTypeCinema,kBussinessTypeHotel,kBussinessTypeSupermarker][type];
    }else {
        self.requestFindBussiness.category = nil ;
    }
    if (keyword.length != 0) {
        self.requestFindBussiness.keyword = keyword;
    }
    if (type != BussinessTypeNone || keyword.length != 0 ) {
        self.requestFindBussiness.page = 1 ;
        [self.bussessContainer removeAllObjects];
        [self loadData];
    }
}

#pragma mark - 私有方法
- (void)loadData {
    kWeakSelf(myself);
    [TQWGetData getDiPinBussiness:self.requestFindBussiness completeHandler:^(TQWFindBussinessRespond *bussinessRespond, NSError *error) {
        [myself.bussessContainer  addObjectsFromArray:bussinessRespond.businesses];
        _loadDataCompleteOperater(error);
    }];

}

- (void)prestrainFunction{
    //预加载
    if ((self.bussessContainer.count + kPrepageRowNumber -1) / kPrepageRowNumber == self.requestFindBussiness.page) {
        self.requestFindBussiness.page ++ ;
        NSLog(@"page : %ld",self.requestFindBussiness.page);
        [self loadData];
    }else {
        NSError *error = [NSError errorWithDomain:@"没有更多数据" code:kNotMoreData userInfo:nil];
        _loadDataCompleteOperater(error);
    }
}

#pragma mark - 添加通知
- (instancetype)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange) name:kCurrentCityChangeNotification object:nil];
    }
    return self;
}
- (void)cityChange{
    self.requestFindBussiness.city = kCurrentCityNameValue;
    self.requestFindBussiness.sortRule = SortRuleProductRating;
    [self.bussessContainer removeAllObjects];
}

#pragma mark - 生命周期相关方法

- (void)dealloc{
    kRemoveAllObserver;
    NSLog(@"%@,销毁了",[self class]);
}

@end
