//
//  TQWAnnotationView.h
//  TMTime
//
//  Created by tarena33 on 16/4/11.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <MapKit/MapKit.h>
@class TQWAnnotation;

@interface TQWAnnotationView : MKAnnotationView
+ (instancetype)annotationViewWithMakView:(MKMapView*)mapView annotation:(TQWAnnotation*)annotation ;
@end
