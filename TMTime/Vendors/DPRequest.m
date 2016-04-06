//
//  DPRequest.m
//  apidemo
//
//  Created by ZhouHui on 13-1-28.
//  Copyright (c) 2013年 Dianping. All rights reserved.
//

#import "DPRequest.h"
#import "constant.h"
#import <CommonCrypto/CommonDigest.h>

#define kDPRequestTimeOutInterval   180.0
#define kDPRequestStringBoundary    @"9536429F8AAB441bA4055A74B72B57DE"



@implementation DPRequest
#pragma mark - Private Methods

- (void)appendUTF8Body:(NSMutableData *)body dataString:(NSString *)dataString {
    [body appendData:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
		
		if ([elements count] <= 1) {
			return nil;
		}
		
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}

- (NSMutableData *)postBodyHasRawData:(BOOL*)hasRawData
{
//    NSString *bodyPrefixString = [NSString stringWithFormat:@"--%@\r\n", kDPRequestStringBoundary];
//    NSString *bodySuffixString = [NSString stringWithFormat:@"\r\n--%@--\r\n", kDPRequestStringBoundary];
//    
//    NSMutableDictionary *dataDictionary = [NSMutableDictionary dictionary];
//    
//    NSMutableData *body = [NSMutableData data];
//    [self appendUTF8Body:body dataString:bodyPrefixString];
//    
//    for (id key in [params keyEnumerator])
//    {
//        if (([[params valueForKey:key] isKindOfClass:[UIImage class]]) || ([[params valueForKey:key] isKindOfClass:[NSData class]]))
//        {
//            [dataDictionary setObject:[params valueForKey:key] forKey:key];
//            continue;
//        }
//        
//        [self appendUTF8Body:body dataString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", key, [params valueForKey:key]]];
//        [self appendUTF8Body:body dataString:bodyPrefixString];
//    }
//    
//    if ([dataDictionary count] > 0)
//    {
//        *hasRawData = YES;
//        for (id key in dataDictionary)
//        {
//            NSObject *dataParam = [dataDictionary valueForKey:key];
//            
//            if ([dataParam isKindOfClass:[UIImage class]])
//            {
//                NSData* imageData = UIImagePNGRepresentation((UIImage *)dataParam);
//                [self appendUTF8Body:body dataString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"file\"\r\n", key]];
//                [self appendUTF8Body:body dataString:[NSString stringWithString:@"Content-Type: image/png\r\nContent-Transfer-Encoding: binary\r\n\r\n"]];
//                [body appendData:imageData];
//            }
//            else if ([dataParam isKindOfClass:[NSData class]])
//            {
//                [self appendUTF8Body:body dataString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"file\"\r\n", key]];
//                [self appendUTF8Body:body dataString:[NSString stringWithString:@"Content-Type: content/unknown\r\nContent-Transfer-Encoding: binary\r\n\r\n"]];
//                [body appendData:(NSData*)dataParam];
//            }
//            [self appendUTF8Body:body dataString:bodySuffixString];
//        }
//    }
//    
//    return body;
	return nil;
}

#pragma mark - Public Methods

+ (NSString *)getParamValueFromUrl:(NSString*)url paramName:(NSString *)paramName
{
    if (![paramName hasSuffix:@"="])
    {
        paramName = [NSString stringWithFormat:@"%@=", paramName];
    }
    
    NSString * str = nil;
    NSRange start = [url rangeOfString:paramName];
    if (start.location != NSNotFound)
    {
        // confirm that the parameter is not a partial name match
        unichar c = '?';
        if (start.location != 0)
        {
            c = [url characterAtIndex:start.location - 1];
        }
        if (c == '?' || c == '&' || c == '#')
        {
            NSRange end = [[url substringFromIndex:start.location+start.length] rangeOfString:@"&"];
            NSUInteger offset = start.location+start.length;
            str = end.location == NSNotFound ?
            [url substringFromIndex:offset] :
            [url substringWithRange:NSMakeRange(offset, end.location)];
            str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }
    return str;
}
//连接时调用,主要作用是算出请求串
+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params
{
	NSURL* parsedURL = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:[self parseQueryString:[parsedURL query]]];
	if (params) {
		[paramsDic setValuesForKeysWithDictionary:params];
	}
	
	NSMutableString *signString = [NSMutableString stringWithString:kDPAppKey];
	NSMutableString *paramsString = [NSMutableString stringWithFormat:@"appkey=%@", kDPAppKey];
	NSArray *sortedKeys = [[paramsDic allKeys] sortedArrayUsingSelector: @selector(compare:)];
	for (NSString *key in sortedKeys) {
		[signString appendFormat:@"%@%@", key, [paramsDic objectForKey:key]];
		[paramsString appendFormat:@"&%@=%@", key, [paramsDic objectForKey:key]];
	}
    [signString appendString:kDPAppSecret];
	unsigned char digest[CC_SHA1_DIGEST_LENGTH];
	NSData *stringBytes = [signString dataUsingEncoding: NSUTF8StringEncoding];
	if (CC_SHA1([stringBytes bytes], (unsigned int)[stringBytes length], digest)) {
		/* SHA-1 hash has been calculated and stored in 'digest'. */
		NSMutableString *digestString = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
		for (int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
			unsigned char aChar = digest[i];
			[digestString appendFormat:@"%02X", aChar];
		}
		[paramsString appendFormat:@"&sign=%@", [digestString uppercaseString]];
		return [NSString stringWithFormat:@"%@?%@", [parsedURL path], [paramsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	} else {
		return nil;
	}
}

+ (NSString*)requestWithURL:(NSString *)url
                     params:(NSDictionary *)params
{
    NSLog(@"%@",[kDPAPIDomain stringByAppendingString:[self serializeURL:url params:params]]);
    return  [kDPAPIDomain stringByAppendingString:[self serializeURL:url params:params]] ;
}

+ (NSString *)requestWithURL:(NSString *)url paramsString:(NSString *)paramsString{
    return [self requestWithURL:[NSString stringWithFormat:@"%@?%@", url, paramsString] params:nil];
}


@end



