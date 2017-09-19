//
//  AppManager.m
//  YuTongApp
//
//  Created by bszx on 2017/9/13.
//  Copyright © 2017年 杜小猛. All rights reserved.
//

#import "AppManager.h"
#import "AdvertiseView.h"

@implementation AppManager

SINGLETON_FOR_CLASS(AppManager);

- (void)showAdViewBegin{
    //加载广告
    // 1.判断沙盒中是否存在广告图片，如果存在，直接显示
    NSString *filePath = [self getFilePathWithImageName:[kUserDefaults valueForKey:adImageName]];
    
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (isExist) {// 图片存在
        
        AdvertiseView *advertiseView = [[AdvertiseView alloc] initWithFrame:kScreen_Bounds];
        advertiseView.filePath = filePath;
        [advertiseView show];
    }
    
    // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
    [self getAdvertisingImage];
}

#pragma mark ————— FPS 监测 —————
+(void)showFPS{
    
//    YYFPSLabel *_fpsLabel = [YYFPSLabel new];
//    [_fpsLabel sizeToFit];
//    _fpsLabel.bottom = KScreenHeight - 55;
//    _fpsLabel.right = KScreenWidth - 10;
//    //    _fpsLabel.alpha = 0;
//    [kAppWindow addSubview:_fpsLabel];
    
}

/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
}
/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

/**
 *  初始化广告页面
 */
- (void)getAdvertisingImage
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"get_guide_data" forKey:@"a"];
    [param setValue:@"basis" forKey:@"c"];
    
    
    NSMutableDictionary *newDic = param;
    BOOL isSign = [newDic.allKeys containsObject:@"sign"];
    if (isSign) {
        [newDic removeObjectForKey:@"sign"];
    }
    param = newDic;
    //签名
    NSString *md5Str = [GlobalTools signNewMd5StringWithParameDic:param isGET:YES];
    [param setValue:md5Str forKey:@"sign"];
    
    //服务器加签名 链接地址。
    [GlobalTools stringWithDict:param];
    
    [PPNetworkHelper GET:URL_main parameters:param success:^(id responseObject) {
        
        if (ValidDict(responseObject)) {
            //服务器返回的数据
            NSString *dataStr = responseObject[@"data"];
            id dict = [GlobalTools dataDicDecodeWithString:dataStr];
            
            if (ValidDict(dict)) {
                [kUserDefaults setValue:[dict valueForKey:@"guide_img"] forKey:@"adImage"];
                [kUserDefaults setValue:[dict valueForKey:@"count_down"] forKey:@"adTime"];
                [kUserDefaults setValue:[dict valueForKey:@"img_url"] forKey:@"adUrl"];
                [kUserDefaults setValue:dict[@"title"] forKey:@"adVTitle"];
            }
            NSString *imageUrl = [dict valueForKey:@"guide_img"];
            //
            //            // 获取图片名:43-130P5122Z60-50.jpg
            NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
            NSString *imageName = stringArr.lastObject;
            
            // 拼接沙盒路径
            NSString *filePath = [self getFilePathWithImageName:imageName];
            
            BOOL isExist = [self isFileExistWithFilePath:filePath];
            
            if (!isExist){// 如果该图片路径不存在，则删除老图片，下载新图片
                
                [self downloadAdImageWithUrl:imageUrl imageName:imageName];
                
            }
        }
    } failure:^(NSError *error) {
        
    }];
    
}

/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *encoding = [imageUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSData *data1 = [encoding dataUsingEncoding:NSUTF8StringEncoding];
        
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([data1 writeToFile:filePath atomically:YES]) {// 保存成功
            //        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            NSLog(@"保存成功");
            //            [self deleteOldImage];
            [kUserDefaults setValue:imageName forKey:adImageName];
            [kUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
        }else{
            NSLog(@"保存失败");
        }
        
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage
{
    NSString *imageName = [kUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:adImageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}


@end
