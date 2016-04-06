//
//  NSString+regular.h
//  TMTime
//
//  Created by 涂清文 on 16/4/2.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (regular)
/**
 *  将符合表达式规则的字符串返回
 *
 *  @param expression 正则表达式
 *
 *  @return 字符串数组
 */
- (NSArray<NSString*>*)matchRegularExpression:(NSString*)expression;
@end
