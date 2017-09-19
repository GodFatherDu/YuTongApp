//
//  AppManager.h
//  YuTongApp
//
//  Created by bszx on 2017/9/13.
//  Copyright © 2017年 杜小猛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppManager : NSObject

SINGLETON_FOR_HEADER(AppManager);

#pragma mark ————— APP启动接口 —————
- (void)showAdViewBegin;

#pragma mark ————— FPS 监测 —————
+(void)showFPS;

@end
