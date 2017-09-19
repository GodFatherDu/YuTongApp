//
//  XDTabBarView.h
//  YuTongApp
//
//  Created by Duxiaomeng on 17/9/20.
//  Copyright © 2017年 杜小猛. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XDTabBarView, XDTabBarItem;

//给每个按钮定义协议 与 方法
@protocol TabBarDelegate <NSObject>

@optional
- (void)tabBar:(XDTabBarView *)tabBarView didSelectedItemFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface XDTabBarView : UIView

/**
 *  TabBar item title color
 */
@property (nonatomic, strong) UIColor *itemTitleColor;

/**
 *  TabBar selected item title color
 */
@property (nonatomic, strong) UIColor *selectedItemTitleColor;

/**
 *  TabBar item title font
 */
@property (nonatomic, strong) UIFont *itemTitleFont;

/**
 *  TabBar item's badge title font
 */
@property (nonatomic, strong) UIFont *badgeTitleFont;

/**
 *  TabBar item image ratio
 */
@property (nonatomic, assign) CGFloat itemImageRatio;

/**
 *  TabBar's item count
 */
@property (nonatomic, assign) NSInteger tabBarItemCount;

/**
 *  TabBar's selected item
 */
@property (nonatomic, strong) XDTabBarItem *selectedItem;

/**
 *  TabBar items array
 */
@property (nonatomic, strong) NSMutableArray *tabBarItems;

/**
 *  TabBar delegate
 */
@property (nonatomic, weak) id<TabBarDelegate> delegate;

/**
 *  Add tabBar item
 */
- (void)addTabBarItem:(UITabBarItem *)item;


@end
