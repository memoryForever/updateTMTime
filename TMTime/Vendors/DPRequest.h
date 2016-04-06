//
//  DPRequest.h
//  apidemo
//
//  Created by ZhouHui on 13-1-28.
//  Copyright (c) 2013年 Dianping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPRequest : NSObject
+ (NSString *)requestWithURL:(NSString *)url
                       params:(NSDictionary *)params;
+ (NSString *)requestWithURL:(NSString *)url
                paramsString:(NSString *)paramsString;
@end

