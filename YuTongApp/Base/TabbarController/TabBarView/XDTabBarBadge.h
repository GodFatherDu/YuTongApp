//
//  XDTabBarBadge.h
//  YuTongApp
//
//  Created by Duxiaomeng on 17/9/20.
//  Copyright © 2017年 杜小猛. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 tabbar 红点
 */

@interface XDTabBarBadge : UIButton

/**
 *  TabBar item badge value
 */
@property (nonatomic, copy) NSString *badgeValue;

/**
 *  TabBar's item count
 */
@property (nonatomic, assign) NSInteger tabBarItemCount;

/**
 *  TabBar item's badge title font
 */
@property (nonatomic, strong) UIFont *badgeTitleFont;


@end
