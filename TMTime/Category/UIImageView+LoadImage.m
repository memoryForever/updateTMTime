//
//  UIImageView+LoadImage.m
//  TMTime
//
//  Created by 涂清文 on 16/4/4.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "UIImageView+LoadImage.h"
#import <YYKit/YYKit.h>
#import <objc/runtime.h>

@implementation UIImageView (LoadImage)
- (void)loadImageWithURL:(NSString *)URL{
    if (URL == nil || URL.length == 0 ) {
        self.bounds = CGRectZero;
        self.hidden = YES;
        return;
    }
    if ([[URL substringToIndex:7] isEqualToString:@"http://"] || [[URL substringToIndex:8] isEqualToString:@"https://"] ) {
        [UIView transitionWithView:self duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            self.imageURL = [NSURL URLWithString:URL];
        } completion:nil];
        
    }else{
        [UIView transitionWithView:self duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            NSLog(@"%@",URL);
            self.imageURL = [NSURL fileURLWithPath:URL];
        } completion:nil];
       
    }
    return ;
}

- (void)noTranformloadImageWithURL:(NSString *)URL{
    self.imageURL = [NSURL URLWithString:URL]   ;
}
//- (void)setImage:(UIImage *)image{
//    //[self methodList:image];
//   
//    [UIView transitionWithView:self duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
//       
//    } completion:nil];
//}

//- (void)methodList:(UIImage *)image{
//    id (*imageFunc)(id,SEL ,void *) = NULL;
//    Class currentClass=[self class];
//    while (currentClass) {
//        unsigned int methodCount;
//        Method *methodList = class_copyMethodList(currentClass, &methodCount);
//        unsigned int i = 0;
//        for (; i < methodCount; i++) {
//            NSString *className =[NSString stringWithCString:class_getName(currentClass) encoding:NSUTF8StringEncoding];
//            NSString *methodName = [NSString stringWithCString:sel_getName(method_getName(methodList[i])) encoding:NSUTF8StringEncoding];
//             //  NSLog(@"----%@,%@",className,methodName);
//                if ([methodName isEqualToString:@"setImage:"]) {
//                    NSLog(@"22%@,%@",className,methodName);
//                   imageFunc = method_getImplementation(methodList[i]);
//                }
//        }
//        free(methodList);
//        currentClass = class_getSuperclass(currentClass);
//    }
//            imageFunc(self,_cmd,CFBridgingRetain(image));
//            imageFunc = NULL;
//}

@end
