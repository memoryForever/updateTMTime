//
//  TQWDBRequestFindBussiness.m
//  TMTime
//
//  Created by 涂清文 on 16/4/2.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWDBRequestFindBussiness.h"
#import "constant.h"

@interface TQWDBRequestFindBussiness()
@property (nonatomic,strong)NSMutableDictionary *param;

@end



@implementation TQWDBRequestFindBussiness
#pragma mark - 懒加载
-(NSMutableDictionary *)param{
    if (!_param) {
        _param = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _param;
}
#pragma mark - 重写setter方法
-(void)setLatitude:(CGFloat )latitude{
    _latitude = latitude;
    if (self.param[@"city"]) {
        [self.param removeObjectForKey:@"city"];
    }
    [self.param setObject:@(latitude) forKey:@"latitude"];
}

-(void)setLongitude:(CGFloat)longitude{
    _longitude = longitude;
    if (self.param[@"city"]) {
        [self.param removeObjectForKey:@"city"];
    }
    [self.param setObject:@(longitude) forKey:@"longitude"];
}

-(void)setMapType:(MapType)mapType{
    _mapType = mapType;
    [self.param setObject:@(_mapType) forKey:@"offset_type"];
    [self.param setObject:@(_mapType) forKey:@"out_offset_type"];
}

-(void)setRadius:(NSUInteger)radius{
    _radius = radius;
    [self.param setObject:@(_radius) forKey:@"radius"];
}
-(void)setCity:(NSString *)city{
    _city = city;
    if (self.param[@"latitude"]) {
        [self.param removeObjectForKey:@"latitude"];
        [self.param removeObjectForKey:@"longitude"];
        [self.param removeObjectForKey:@"radius"];
        [self.param removeObjectForKey:@"offset_type"];
        [self.param removeObjectForKey:@"out_offset_type"];
    }
    [self.param setObject:_city forKey:@"city"];
}
- (void)setRegion:(NSString *)region{
    _region = region;
    [self.param setObject:_region forKey:@"region"];
}

- (void)setCategory:(NSString *)category{
    _category = category;
    if (category.length == 0 ) {
        [self.param removeObjectForKey:@"category"];
        return;
    }
    [self.param setObject:_category forKey:@"category"];
}

- (void)setKeyword:(NSString *)keyword{
    _keyword = keyword;
    if (keyword.length == 0) {
        [self.param removeObjectForKey:@"keyword"];
    }
    [self.param setObject:_keyword forKey:@"keyword"];
}

- (void)setHasCoupon:(BOOL)hasCoupon{
    _hasCoupon = hasCoupon;
    [self.param setObject:@(_hasCoupon) forKey:@"has_coupon"];
}
- (void)setHasDeal:(BOOL)hasDeal{
    _hasDeal = hasDeal ;
    [self.param setObject:@(_hasDeal) forKey:@"has_deal"];
}
- (void)setHasOnlineReservation:(BOOL)hasOnlineReservation{
    _hasOnlineReservation = hasOnlineReservation;
    [self.param setObject:@(_hasOnlineReservation) forKey:@"has_online_reservation"];
}
- (void)setSortRule:(SortRule)sortRule{
    _sortRule = sortRule;
    [self.param setObject:@(sortRule) forKey:@"sort"];
}

- (void)setLimitPaginalMaxBuessinesCount:(NSInteger)limitPaginalMaxBuessinesCount{
    _limitPaginalMaxBuessinesCount = limitPaginalMaxBuessinesCount;
    [self.param setObject:@(limitPaginalMaxBuessinesCount) forKey:@"limit"];
}
- (void)setPage:(NSInteger)page{
    _page = page ;
    [self.param setObject:@(page) forKey:@"page"];
}

- (void)setDataFormat:(NSString *)dataFormat{
    _dataFormat = dataFormat ;
    [self.param setObject:_dataFormat forKey:@"format"];
}
#pragma mark - 重写alloc方法
+(instancetype)alloc{
   static TQWDBRequestFindBussiness *_bussiness;
    if (!_bussiness) {
        _bussiness = [super alloc];
    }
    return _bussiness;
}
#pragma mark - 工厂方法
+(instancetype)defaultRequest{
    return [[TQWDBRequestFindBussiness alloc]init];
}

#pragma mark - 实例方法
-(NSDictionary*)getParams{
 
    [self.param setObject:@2 forKey:@"platform"];
    return self.param;
}
@end
