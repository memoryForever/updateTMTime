//
//  TQWCityListViewModel.h
//  TMTime
//
//  Created by tarena33 on 16/4/7.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQWCityListViewModel : NSObject
/** tableView list 属性 **/
- (NSInteger)sectionNumber;
- (NSInteger)rowNumberWithSection:(NSInteger)section;
- (NSString*)sectionHeadWithSection:(NSInteger)section;
- (NSString*)cityNameWithIndexPath:(NSIndexPath*)indexPath;
- (NSArray<NSString*>*)sectionIndexTitles;
/** model属性 **/
- (void)getCityListCompleteHandler:(void(^)(NSError *error))completeHandler;
/**
 *  回到当前用户所在的城市
 */
- (void)backCurrentCityCompleteHandler:(void(^)(NSError* error))completeHandler;
@end
