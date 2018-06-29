//
//  QZZViewController.m
//  
//
//  Created by qinzhongzeng on 2016/10/12.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import "QZZViewController.h"


@interface QZZViewController ()

@end

@implementation QZZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = QZZUIColorWithWhite(238);
    //设置导航栏
    [self setupNavType];
    //解决滚动视图无故偏移
    [self adjustsScrollViewScrollViewInsets];
    
    //隐藏导航栏阴影视图
    self.contentLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    self.contentLineImageView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //获取阴影视图
    self.contentLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    self.contentLineImageView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    //显示阴影视图
    self.contentLineImageView.hidden = NO;
}
#pragma mark - 解决滚动视图无故偏移
- (void)adjustsScrollViewScrollViewInsets{
    //解决滚动视图无故偏移
    if (@available(iOS 11.0, *)) {
        // iOS 11 及其以上系统运行
        if (self.scrollView != nil) {
            self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    } else {
        //解决滚动视图无故偏移
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - 设置导航栏左侧的返回按钮
- (void)setupNavType{
    
    //设置导航栏左侧按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage qzz_imagePathWithName:@"nav_back" bundle:@"QZZMainViewKit" targetClass:[self class]] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backItemDidClick) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 40, 40);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

#pragma mark - ********获取阴影视图********
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            
            return imageView;
        }
    }
    return nil;
}

#pragma mark - method
/**
 *  导航栏上返回按钮的回调
 */
- (void)backItemDidClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    if (self.isStatusBarLight) {
        return UIStatusBarStyleLightContent;
    }else{
        return UIStatusBarStyleDefault;
    }
}

- (void)tishi:(NSString *)title{
    CGFloat y = NAV_HEIGHT;
    __block UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((Screen_Width / 2 - 150), y+10, 300, 30)];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 5;
    label.backgroundColor = [UIColor colorWithWhite:0/255.0 alpha:0.6];
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    [self.view bringSubviewToFront:label];
    [UIView animateWithDuration:0.5f animations:^{
        label.alpha = 0.9f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:3.5f animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
            label = nil;
        }];
    }];
}
@end
