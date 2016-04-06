//
//  NSObject+Parser.h
//  TMTime
//
//  Created by 涂清文 on 16/4/1.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Parser)
+(void)parserData:(NSString *)stringURL params:(NSDictionary *)params modelClass:(Class)classes completeHandler:(void (^)(id repondObject, NSError *))completeHandler;
+(id)parserJson:(id)json;
@end
