//
//  NSObject+MapView.m
//  TMTime
//
//  Created by tarena33 on 16/4/11.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "NSObject+MapView.h"
#import <MapKit/MapKit.h>
#import <objc/runtime.h>

@implementation NSObject (MapView)
//添加主类弱引用

- (void)setCategoryWeakMapViwe:(MKMapView *)categoryWeakMapViwe{
    objc_setAssociatedObject(self, @selector(categoryWeakMapViwe), categoryWeakMapViwe, OBJC_ASSOCIATION_ASSIGN);
}
- (MKMapView *)categoryWeakMapViwe{
    return objc_getAssociatedObject(self, _cmd) ;
}







@end
