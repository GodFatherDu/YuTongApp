//
//  XDMainTabBarController.h
//  YuTongApp
//
//  Created by Duxiaomeng on 17/9/20.
//  Copyright © 2017年 杜小猛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDTabBarView.h"

@interface XDMainTabBarController : UITabBarController

/**
 *  TabBar
 */
@property (nonatomic, strong) XDTabBarView *TabBar;
/**
 * tabbar 图片占比，默认 0.7f， 如果是1 就没有文字
 */
@property (nonatomic, assign) CGFloat itemImageRatio;


/**
 *  System will display the original controls so you should call this line when you change any tabBar item, like: `- popToRootViewController`, `someViewController.tabBarItem.title = xx`, etc.
 *  Remove origin controls
 */
- (void)removeOriginControls;


@end
