//
//  AdvertiseView.m
//  YuTongApp
//
//  Created by bszx on 2017/9/19.
//  Copyright © 2017年 杜小猛. All rights reserved.
//

#import "AdvertiseView.h"

@interface AdvertiseView()

@property (nonatomic, strong) UIImageView *adView;

@property (nonatomic, strong) UIButton *countBtn;

@property (nonatomic, strong) NSTimer *countTimer;

@property (nonatomic, assign) int count;

@end

// 广告显示的时间
static int const showtime = 3;

@implementation AdvertiseView


- (NSTimer *)countTimer
{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        // 1.广告图片
        _adView = [[UIImageView alloc] initWithFrame:frame];
        _adView.userInteractionEnabled = YES;
        _adView.contentMode = UIViewContentModeScaleAspectFill;
        _adView.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAd)];
        [_adView addGestureRecognizer:tap];
        
        // 2.跳过按钮
        CGFloat btnW = 60;
        CGFloat btnH = 30;
        _countBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - btnW - 24, btnH, btnW, btnH)];
        [_countBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d", showtime] forState:UIControlStateNormal];
        _countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _countBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
        _countBtn.layer.cornerRadius = 4;
        
        [self addSubview:_adView];
        [self addSubview:_countBtn];
    }
    return self;
}

- (void)setFilePath:(NSString *)filePath
{
    _filePath = filePath;
    
    NSString *imageUrl = [kUserDefaults valueForKey:@"adImage"];
    
    [_adView sd_setImageWithURL:[NSURL URLWithString:imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
//    _adView.image = [UIImage imageWithContentsOfFile:filePath];
}

- (void)pushToAd{
    
    [self dismiss];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushtoad" object:nil userInfo:nil];
}

- (void)countDown
{
    _count --;
    [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",_count] forState:UIControlStateNormal];
    if (_count == 0) {
        
        [self dismiss];
    }
}

- (void)show
{
    // 倒计时方法1：GCD
    //    [self startCoundown];
    
    // 倒计时方法2：定时器
    
    NSString *time = [kUserDefaults valueForKey:@"adTime"];
    _count = time.intValue;
    
    [self startTimer];
    
    UIViewController *currentvc = [UIViewController currentViewController];
    
    
    //    tab.selectedViewController;
    [currentvc.view insertSubview:self atIndex:2000];
    
//    if ([currentvc isKindOfClass:[LoginViewController class]]) {
//        
//        NSString *userToken = [kUserDefaults valueForKey:@"tokenKey"];
//        if (ValidStr(userToken)) {
//            DLog(@"token is not null%@",userToken);
//            
//            //        //跳转主页
//            [kRootViewController.parentViewController.view insertSubview:self atIndex:2000];
//        }else{
//            
//            //    tab.selectedViewController;
//            [kAppWindow insertSubview:self atIndex:2000];
//        }
//    }else{
//
//    }
    
}

// 定时器倒计时
- (void)startTimer
{
    _count = showtime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSDefaultRunLoopMode];
}

// GCD倒计时
- (void)startCoundown
{
    __block int timeout = showtime + 1; //倒计时时间 + 1
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self dismiss];
                
            });
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",timeout] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

// 移除广告页面
- (void)dismiss
{
    [self.countTimer invalidate];
    self.countTimer = nil;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
