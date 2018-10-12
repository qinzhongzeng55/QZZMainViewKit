//
//  QZZNavigationController.m
//
//
//  Created by qinzhongzeng on 16/8/11.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import "QZZNavigationController.h"

@interface QZZNavigationController ()

@end

@implementation QZZNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)initialize{
    //********导航栏样式设置********//
    UINavigationBar *navBar = [UINavigationBar appearance];
    //1) 设置导航条背景
    NSString *imageName = @"nav_bg";
    if (iPhone5or5cor5sorSE) {
        imageName = [NSString stringWithFormat:@"nav_bg_%@",@"640"];
    }else if (iPhone6or6sor7) {
        imageName = [NSString stringWithFormat:@"nav_bg_%@",@"750"];
    }else if (iPhone6Plusor6sPlusor7Plus) {
        imageName = [NSString stringWithFormat:@"nav_bg_%@",@"1242"];
    }else if(iPhoneXXS){
        imageName = [NSString stringWithFormat:@"nav_bg_%@",@"1125"];
    }else if (iPhoneXRXSMax){
        imageName = [NSString stringWithFormat:@"nav_bg_%@",@"2688"];
    }else{
        imageName = [NSString stringWithFormat:@"nav_bg_%@",@"1125"];
    }
    [navBar setBackgroundImage:[UIImage qzz_imagePathWithName:imageName bundle:@"QZZMainViewKit" targetClass:[self class]] forBarMetrics:UIBarMetricsDefault];
    
    //2)设置导航栏标题样式
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName : [UIColor whiteColor],
                           NSFontAttributeName : [UIFont boldSystemFontOfSize:18]
                           };
    [navBar setTitleTextAttributes:dict];
    
    //3)设置两侧按钮的颜色
    [navBar setTintColor:[UIColor whiteColor]];

    //********导航栏的内容样式设置********//
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
//    // 设置普通状态
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
//    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//
//    // 设置不可用状态
//    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
//    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
//    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
//    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [super pushViewController:viewController animated:animated];
}
@end
