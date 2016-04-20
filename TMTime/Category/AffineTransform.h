//
//  AffineTransform.h
//  TMTime
//
//  Created by tarena33 on 16/4/16.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,TransformStyle) {
    TransformStyleNone,
    TransformStyleTopNoChange,
    TransformStyleBottomNoChange,
    TransformStyleLeftNoChange ,
    TransformStyleRightNoChange,
    TransformStyleCenterNoChange,
};

@interface AffineTransform : UIView

@end
