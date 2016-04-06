//
//  NSObject+UseMasterClassMethod.m
//  TMTime
//
//  Created by 涂清文 on 16/4/6.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "NSObject+UseMasterClassMethod.h"
#import <objc/objc-runtime.h>


@implementation NSObject (UseMasterClassMethod)
- (void)masterClassMethodName:(NSString*)name parameter:(id)param{
    if (!name ) {
        return;
    }
    NSString * performMethod = name;
    Class currentClass       = [self class];
    NSInteger secondTime     = 0 ;
    IMP methodImpletemention = NULL ;
    SEL methodSelector       = NULL ;
    unsigned int methodListTotal ;
    Method *methodList = class_copyMethodList(currentClass, &methodListTotal);
    for (NSInteger i = 0; i < methodListTotal; i ++ ) {
        Method method = methodList[i];
        NSString *methodName = [NSString stringWithCString:sel_getName(method_getName(method)) encoding:NSUTF8StringEncoding];
        
        if ([performMethod isEqualToString:methodName]) {
            secondTime ++;
            methodImpletemention =  method_getImplementation(method);
            methodSelector       = method_getName(method);
            if (secondTime == 2 ) {
                break ;
            }
        }
    }
    if (!methodImpletemention) {
        return ;
    }
    typedef void(*FUNCTION) (id ,SEL ,id);
    FUNCTION func = (FUNCTION)methodImpletemention;
         func(currentClass ,methodSelector,param);
    free(methodList);
    func = NULL ;
    return ;
}

@end

