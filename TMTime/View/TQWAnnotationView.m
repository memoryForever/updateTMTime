//
//  TQWAnnotationView.m
//  TMTime
//
//  Created by tarena33 on 16/4/11.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWAnnotationView.h"
#import "TQWAnnotation.h"

#define kAnnotationReuseIdentifier @"annotationReuseIdentifier"

@interface TQWAnnotationView()
@property (nonatomic, weak) UIImageView *TQWLeftImageView;
@end

@implementation TQWAnnotationView
- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        self.leftCalloutAccessoryView = imageView;
        self.TQWLeftImageView = imageView;
        self.canShowCallout = YES ;
        self.TQWLeftImageView.userInteractionEnabled = YES;
    }
    return  self;
}
- (void)setAnnotation:(TQWAnnotation*)annotation{
    [super setAnnotation:annotation];
    [self.TQWLeftImageView loadImageWithURL:annotation.URLImage];
    self.image = [UIImage imageNamed:@"category_1"];
}

+ (instancetype)annotationViewWithMakView:(MKMapView *)mapView annotation:(TQWAnnotation *)annotation{
   TQWAnnotationView *annotationView = (TQWAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:kAnnotationReuseIdentifier];
    if (!annotationView) {
        annotationView = [[TQWAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:kAnnotationReuseIdentifier];
    }
    
    return annotationView;
}
@end
