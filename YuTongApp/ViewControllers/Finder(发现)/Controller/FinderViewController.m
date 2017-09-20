//
//  FinderViewController.m
//  YuTongApp
//
//  Created by bszx on 2017/9/20.
//  Copyright © 2017年 杜小猛. All rights reserved.
//

#import "FinderViewController.h"
#import "AXWebViewController.h"
@interface FinderViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FinderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mTableView.dataSource =self;
    self.mTableView.delegate = self;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTableInBundle(@"back", @"AXWebViewController", [NSBundle bundleWithPath:[[[NSBundle bundleForClass:NSClassFromString(@"AXWebViewController")] resourcePath] stringByAppendingPathComponent:@"AXWebViewController.bundle"]], @"Back") style:0 target:nil action:nil];
    
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifer = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.textLabel.text = [NSString stringWithFormat:@"索引---%ld",(long)indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            AXWebViewController *webVC = [[AXWebViewController alloc] initWithURL:[NSURL fileURLWithPath:[NSBundle.mainBundle pathForResource:@"Swift" ofType:@"pdf"]]];
            webVC.title = @"Swift.pdf";
            webVC.showsToolBar = NO;
            if (AX_WEB_VIEW_CONTROLLER_iOS9_0_AVAILABLE()) {
                webVC.webView.allowsLinkPreview = YES;
            }
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
        case 1:
        {
            AXWebViewController *webVC = [[AXWebViewController alloc] initWithAddress:@"http://www.baidu.com"];
            webVC.showsToolBar = NO;
            if (AX_WEB_VIEW_CONTROLLER_iOS9_0_AVAILABLE()) {
                webVC.webView.allowsLinkPreview = YES;
            }
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
        case 2:
        {
            AXWebViewController *webVC = [[AXWebViewController alloc] initWithAddress:@"http://www.baidu.com"];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVC];
            nav.navigationBar.tintColor = [UIColor colorWithRed:0.322 green:0.322 blue:0.322 alpha:1.00];
            [self presentViewController:nav animated:YES completion:NULL];
            webVC.showsToolBar = YES;
            webVC.navigationType = 1;
        }
            break;
        case 3: {
            AXWebViewController *webVC = [[AXWebViewController alloc] initWithAddress:@"https://github.com/devedbox/AXWebViewController"];
            webVC.showsToolBar = NO;
            webVC.showsBackgroundLabel = NO;
            if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_9_0) {
                webVC.webView.allowsLinkPreview = YES;
            }
            [self.navigationController pushViewController:webVC animated:YES];
        } break;
        case 4: {
            AXWebViewController *webVC = [[AXWebViewController alloc] initWithAddress:@"https://github.com/devedbox/AXWebViewController/releases/latest"];
            webVC.showsToolBar = NO;
            if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_9_0) {
                webVC.webView.allowsLinkPreview = YES;
            }
            [self.navigationController pushViewController:webVC animated:YES];
        } break;
        default:
            break;
    }
}

//#import <AXPracticalHUD/AXPracticalHUD.h>
//[[AXPracticalHUD sharedHUD] showSimpleInView:self.navigationController.view text:@"清理缓存..." detail:nil configuration:NULL];
//[AXWebViewController clearWebCacheCompletion:^{
//    [[AXPracticalHUD sharedHUD] hide:YES afterDelay:0.5 completion:NULL];
//}];

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
