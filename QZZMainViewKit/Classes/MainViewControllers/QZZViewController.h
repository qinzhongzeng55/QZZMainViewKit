//
//  QZZViewController.h
//  
//
//  Created by qinzhongzeng on 2016/10/12.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//  UIViewController基类
//  隐藏导航栏阴影视图,设置状态栏样式,设置导航栏样式

#import <UIKit/UIKit.h>
#import "QZZMainViewKit.h"

@interface QZZViewController : UIViewController

///导航栏阴影视图
@property (nonatomic, strong) UIImageView *contentLineImageView;

///设置状态栏样式是否是白色
@property (nonatomic,assign) BOOL isStatusBarLight;

@property (nonatomic,strong) UIScrollView *scrollView;

///设置导航栏样式
- (void)setupNavType;
///导航栏左侧返回按钮点击的回调
- (void)backItemDidClick;
///弹出提示框
- (void)tishi:(NSString *)title;
@end
