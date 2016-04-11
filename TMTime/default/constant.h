//
//  constant.h
//  TMTime
//
//  Created by 涂清文 on 16/4/1.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#ifndef constant_h
#define constant_h
/** 起源网自定义数据源token **/
#define kQIYUANTOKEN @"1.0_fNyNmqVjWjvSyHmHekeU115de535"
/** 豆瓣电影相关API **/

#define kDOUBANMOVI_SUBJECT    @"http://api.douban.com/v2/movie/subject/"
#define kDOUBANMOVI_InTheaters @"http://api.douban.com/v2/movie/in_theaters"
#define kDOUBANMOVI_Searsh     @"http://api.douban.com/v2/movie/search"
#define kDOUBANMOVI_250        @"http://api.douban.com/v2/movie/top250"
#define kDOUBANMOVI_ComingSoon @"http://api.douban.com/v2/movie/coming_soon"
#define kDOUBANMOVI_USBox      @"http://api.douban.com/v2/movie/us_box"

/** 点评网 **/
#define kDPAppKey                   @"4123794720"
#define kDPAppSecret                @"5a908d5484254cf4879bb47131bfd822"
#define DPAPIVersion                @"2.0"
#define kDPAPIErrorDomain           @"DPAPIErrorDomain"
#define kDPAPIErrorCodeKey          @"DPAPIErrorCodeKey"
#define kDPAPIDomain				@"http://api.dianping.com"
#define kDPSubDomain                @"/v1/business/find_businesses"
#define kDPSubDomain_rating         @"/v1/review/get_recent_reviews"

/** 定义放回的数据类型 **/
#define kRespondDataTypeJSON @"json"
#define kRespondDataTypeXML  @"xml"


/** plist文件名 **/
#define kPListCityGroups @"cityGroups.plist"


/** 屏幕宽和高 **/
#ifndef kSceenW
   #define kScreenW     [UIScreen mainScreen].bounds.size.width
#endif
#ifndef kScreenH
   #define kScreenH     [UIScreen mainScreen].bounds.size.height
#endif

/** 保存当前城市KEY **/
#define kCurrentCityNameKey   @"currentCityNameKey"
#define kCurrentCityNameValue [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentCityNameKey]
#define kSaveCurrentCityName(__cityName__)  do{[[NSUserDefaults standardUserDefaults] setObject:__cityName__ forKey:kCurrentCityNameKey];\
[[NSUserDefaults standardUserDefaults] synchronize];}while(0)
#define kCurrentCityChangeNotification @"currentCityChange"

#define kSendCityChangeNotification(mySelf)  [[NSNotificationCenter defaultCenter] postNotificationName:kCurrentCityChangeNotification object:mySelf]

/** 设置RGB颜色 **/
#define kRGBAColor(R,G,B,A) [UIColor colorWithRed:R/225.0 green:G/255.0 blue:B/255.0 alpha:A]

/** 移除当前对象所有观察者 **/
#define kRemoveAllObserver    [[NSNotificationCenter defaultCenter] removeObserver:self]
/** 没有更多数据加载 **/
#define kNotMoreData -10000
/** 定位服务未开启 **/
#define kNotLocatinServer -10001

/** 定义弱self **/
#define kWeakSelf(__kMySelf__) __weak typeof(self) __kMySelf__ = self
/**
 *  检测mem
 */
#define kTestMEM NSLog(@"%@,销毁了",[self class])
#endif /* constant_h */
