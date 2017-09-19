//
//  GlobalTools.m
//  YuTongApp
//
//  Created by bszx on 2017/9/19.
//  Copyright © 2017年 杜小猛. All rights reserved.
//

#import "GlobalTools.h"
#import <CommonCrypto/CommonDigest.h>
@implementation GlobalTools

#pragma mark assist func
+ (NSString *)md5:(NSString *)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

//签名
+ (NSString *)signNewMd5StringWithParameDic:(NSMutableDictionary *)parameDic isGET:(BOOL)isGET{
    
    // a c appkey appScope
    NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
    [parameDic setValue:KnetAppKey forKey:@"appKey"];
    [parameDic setValue:knetAppScope forKey:@"appScope"];
    [parameDic setValue:kVersion forKey:@"version"];
    [parameDic setValue:kAppVersion forKey:@"appVersion"];
    [parameDic setValue:@(kAppSystem) forKey:@"appSystem"];
    NSString *resortStr;
    //设置公共参数
    if (!isGET) {
        //post
        [newDict setValue:KnetAppKey forKey:@"appKey"];
        [newDict setValue:knetAppScope forKey:@"appScope"];
        [newDict setValue:kVersion forKey:@"version"];
        [newDict setValue:kAppVersion forKey:@"appVersion"];
        [newDict setValue:@(kAppSystem) forKey:@"appSystem"];
        [newDict setValue:[parameDic valueForKey:@"a"] forKey:@"a"];
        [newDict setValue:[parameDic valueForKey:@"c"] forKey:@"c"];
        if ([[parameDic allKeys] containsObject:@"user_id"]) {
            [newDict setValue:[parameDic valueForKey:@"user_id"] forKey:@"user_id"];
            [newDict setValue:[parameDic valueForKey:@"token"] forKey:@"token"];
            
            //编辑收货地址时id不参与签名
            if (![[parameDic allValues] containsObject:@"editReceiptAddress"])
            {
                [newDict setValue:[parameDic valueForKey:@"id"] forKey:@"id"];
            }
        }
        if ([[parameDic allKeys] containsObject:@"page"]) {
            [newDict setValue:[parameDic valueForKey:@"page"] forKey:@"page"];
        }
        resortStr = [[self class] stringWithDict:newDict];
    }else{
        
        resortStr = [[self class] stringWithDict:parameDic];
    }
    
    //对排序后的字符串md5加密
    NSString *md5Str = [[self class] md5:resortStr];
    DLog(@"md5Str：%@",md5Str);
    return md5Str;
    
}
//字典根据key值排序
+(NSString*)stringWithDict:(NSDictionary*)dict{
    
    NSArray*keys = [dict allKeys];
    
    NSArray*sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
        return[obj1 compare:obj2 options:NSNumericSearch];//正序
    }];
    
    NSString*str =@"";
    
    for(NSString*categoryId in sortedArray) {
        
        id value = [dict objectForKey:categoryId];
        
        if([value isKindOfClass:[NSDictionary class]]) {
            
            value = [self stringWithDict:value];
            
        }
        
        if([str length] !=0) {
            
            str = [str stringByAppendingString:@"&"];
            
        }
        
        str = [str stringByAppendingFormat:@"%@=%@",categoryId,value];
        
    }
    
    NSString *totalUrl = [NSString stringWithFormat:@"%@%@",URL_main,str];
    
    DLog(@"服务器 链接地址  %@",totalUrl);
    
    return str;
}

+ (id)dataDicDecodeWithString:(NSString *)dataString{
    
    if (ValidStr(dataString)) {
        NSMutableString *mStr = [NSMutableString stringWithString:dataString];
        NSRange beforeRange = NSMakeRange(0, 15);
//        NSString *beforeStr = [mStr substringWithRange:beforeRange];
//        NSString *md5Str2 = [self md5:beforeStr];
        
        //判断签名前面字符串是否与sign参数相同
        //                 if ([beforeStr isEqualToString:md5Str]) {
        //去除前面相同位数然后base64解码
        [mStr deleteCharactersInRange:beforeRange];
        NSData *dataFromBase64 = [[NSData alloc]
                                  initWithBase64EncodedString:mStr options:0];
        NSString *base64Encoded = [[NSString alloc] initWithData:dataFromBase64 encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [self dictionaryWithJsonString:base64Encoded];
        
        DLog(@"data:%@",dict);
        
        if (ValidDict(dict)) {
            return dict;
        }else{
            return base64Encoded;
        }
        
    }
    
    return nil;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
//    NSString *dicStr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
