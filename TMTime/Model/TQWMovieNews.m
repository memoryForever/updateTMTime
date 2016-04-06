//
//  TQWMovieNews.m
//  TMTime
//
//  Created by 涂清文 on 16/4/1.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWMovieNews.h"
#import "NSString+regular.h"


@implementation TQWMovieNewsList

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"dataList":@"datalist",
             @"errorCode":@"errorcode",
             @"pageIndex":@"pageindex",
             @"pageSize":@"pagesize",
             @"retcount" : @"retcount" ,
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{
             @"dataList" : [TQWMovieNews class],
             };
}
@end


@implementation TQWMovieNews

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"movieNewTitle":@"subject",
             @"movieNewID":@"itemid",
             @"movieNewContents":@"message",
             @"movieNewDate":@"extfield1",
             };
}
- (void)setMovieNewTitle:(NSString *)movieNewTitle{
    _movieNewTitle = movieNewTitle  ;
    _movieNewTitle = [movieNewTitle stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    _movieNewTitle = [movieNewTitle stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    _movieNewTitle = [movieNewTitle stringByReplacingOccurrencesOfString:@"&quot;" withString:@""];
  //  _movieNewTitle = [movieNewTitle stringByReplacingOccurrencesOfString:@"&amp;" withString:@""];
}

- (void)setMovieNewContents:(NSString *)movieNewContents{
    NSMutableArray *tmpImageURL = [NSMutableArray array];
   NSArray<NSString*>* allSubString  =  [movieNewContents matchRegularExpression:@"<img src=.*>"];
    //或取文件中图片URL;
    for (NSString *subSting in allSubString) {
        [tmpImageURL addObjectsFromArray:[subSting matchRegularExpression:@"http://img.*.jpg"]];
    }
    if (tmpImageURL) {
        _movieNewImageURLS = tmpImageURL;
        _movieNewImageURL = [tmpImageURL firstObject];
        _movieImageCount = tmpImageURL.count;
        if (_movieNewImageURLS.count >= 3 ) {
            self.moviewNewType = movieNewTypeAtlas;
        }else{
            self.moviewNewType = movieNewTypeInbrief;
        }
        
    }
    //去除文字中的特殊符号
    _movieNewContents = [movieNewContents stringByReplacingOccurrencesOfString:@"<p>" withString:@"\r\n"];
    _movieNewContents = [_movieNewContents stringByReplacingOccurrencesOfString:@"</p>" withString:@"\r\n"];
    _movieNewContents = [_movieNewContents stringByReplacingOccurrencesOfString:@"&quot;" withString:@""];
   // _movieNewContents = [_movieNewContents stringByReplacingOccurrencesOfString:@"&amp;" withString:@""];
    
}

@end
