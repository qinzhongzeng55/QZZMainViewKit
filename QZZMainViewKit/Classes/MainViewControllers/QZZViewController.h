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
///无数据页面
@property (nonatomic, strong) UIView *EmptyContentView;
///新建按钮
@property (nonatomic, strong) UIButton *gotoAddBtn;
///刷新按钮
@property (nonatomic, strong) UIButton *refreshBtn;
///加载失败页面
@property (nonatomic, strong) UIView *errorView;

///设置导航栏样式
- (void)setupNavType;
///导航栏左侧返回按钮点击的回调
- (void)backItemDidClick;
///弹出提示框
- (void)tishi:(NSString *)title;
#pragma mark -无数据时的视图
///加载无数据时的视图
- (void)setupEmptyContentView;
//设置是否隐藏无数据时的视图
- (void)hiddenEmptyContentView:(BOOL)isHidden;
///设置无数据时的背景视图的背景图片
- (void)settingBgImgWithImgNameOfEmptyContentView:(NSString *)imgName;
///设置无数据时的背景视图的提示文本
- (void)settingTitleOfEmptyContentView:(NSString *)title;
///设置无数据时的背景视图的提示文本的字体颜色
- (void)settingTitleColorOfEmptyContentView:(UIColor *)color;
///设置无数据时的新建按钮
- (void)hiddenGotoAddBtn:(BOOL)isHidden;
///跳转到新建页面
- (void)gotoAdd;
///重新布局空页面
- (void)layoutSubviewsForEmptyContentView;
#pragma mark - 加载失败时的页面
///加载加载失败时的页面
- (void)setupGetErrorView;
//设置是否隐藏加载失败时的页面
- (void)hiddenGetError:(BOOL)isHidden;
///重新加载数据
- (void)refreshBtnLoad;
///重新布局失败时的页面
- (void)layoutSubviewsForGetErrorView;
///设置失败时页面的大小
- (void)settingErrorViewFrame:(CGRect)frame;
@end
