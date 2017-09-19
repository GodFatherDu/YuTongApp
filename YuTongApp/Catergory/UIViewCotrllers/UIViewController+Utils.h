//
//  UIViewController+Utils.h
//  bszx
//
//  Created by bszx on 2017/5/8.
//  Copyright © 2017年 陈明勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)

+(UIViewController*) currentViewController;

+(UIViewController*)findBestViewController:(UIViewController*)vc;
@end
