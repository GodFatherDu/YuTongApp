//
//  RootNavigationController.h
//  YuTongApp
//
//  Created by bszx on 2017/9/20.
//  Copyright © 2017年 杜小猛. All rights reserved.
//

#import "RxWebViewNavigationViewController.h"

@interface RootNavigationController : RxWebViewNavigationViewController

/*!
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
-(BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;


@end
