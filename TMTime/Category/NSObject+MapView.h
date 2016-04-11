//
//  NSObject+MapView.h
//  TMTime
//
//  Created by tarena33 on 16/4/11.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MKMapView;

@interface NSObject (MapView)<MKMapViewDelegate>
@property (nonatomic,weak) MKMapView*  categoryWeakMapViwe ;
- (void)addAnntationWithCoordinate2D:(CLLocationCoordinate2D)coordinate AnntationClass:(Class)annClassees setupAnntationObject:(void(^)(id anntation))setupAnntationBlock;
@end
