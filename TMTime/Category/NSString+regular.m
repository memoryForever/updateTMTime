//
//  NSString+regular.m
//  TMTime
//
//  Created by 涂清文 on 16/4/2.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "NSString+regular.h"

@implementation NSString (regular)
- (NSArray<NSString *> *)matchRegularExpression:(NSString *)expression{
    NSMutableArray *matchSubStirng = [NSMutableArray array];
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc]initWithPattern:expression options: NSRegularExpressionCaseInsensitive error:nil];
    NSArray *result = [regularExpression matchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    for (NSTextCheckingResult *oneResult in result) {
        [matchSubStirng addObject:[self substringWithRange:oneResult.range]];
    }
    return matchSubStirng;
}
@end
