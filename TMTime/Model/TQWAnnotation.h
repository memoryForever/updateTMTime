//
//  TQWAnnotation.h
//  TMTime
//
//  Created by tarena33 on 16/4/11.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQWAnnotation : NSObject<MKAnnotation>
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, strong) NSString *URLImage;
@end
