//
//  AdvertiseView.h
//  YuTongApp
//
//  Created by bszx on 2017/9/19.
//  Copyright © 2017年 杜小猛. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";

@interface AdvertiseView : UIView

/** 显示广告页面方法*/
- (void)show;

/** 图片路径*/
@property (nonatomic, copy) NSString *filePath;

@end
