//
//  GlobalTools.h
//  YuTongApp
//
//  Created by bszx on 2017/9/19.
//  Copyright © 2017年 杜小猛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalTools : NSObject

//签名
+ (NSString *)signNewMd5StringWithParameDic:(NSMutableDictionary *)parameDic isGET:(BOOL)isGET;

//字典根据key值排序
+(NSString*)stringWithDict:(NSDictionary*)dict;


+ (id)dataDicDecodeWithString:(NSString *)dataString;

@end
