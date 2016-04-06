//
//  NSObject+UseMasterClassMethod.h
//  TMTime
//
//  Created by 涂清文 on 16/4/6.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (UseMasterClassMethod)

/**
*  分类中访问与主类同名的主类方法
*
*  @param methodSel 方法选择器
*  @param param     传入参数
*/
- (void)masterClassMethodName:(NSString*)name parameter:(id)param;
@end
