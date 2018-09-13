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
#import "NavSearchBarView.h"

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
///回到顶部按钮
@property (nonatomic, strong) UIButton *gotoTopBtn;
///刷新按钮
@property (nonatomic, strong) UIButton *refreshBtn;
///加载失败页面
@property (nonatomic, strong) UIView *errorView;
///导航栏上的搜索框
@property (nonatomic, strong) NavSearchBarView *navSearchBarView;


///更新数据
- (void)updateData;
#pragma mark - 导航栏
///设置导航栏样式
- (void)setupNavType;
///导航栏左侧返回按钮点击的回调
- (void)backItemDidClick;
///加载导航栏上的搜索框
- (void)setupNavSearchBar;
///设置搜索框左右两侧的间距
- (void)settingSearchBarLRConstratint:(CGFloat)constraint;
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
#pragma mark - 快捷功能视图
///加载快捷功能视图
- (void)loadKuaiJieCaoZuoView;
///回到顶部
- (void)gotoTopBtnDidClick;
///滚动超过一屏时显示回到顶部按钮
- (void)showGotoTopBtn:(UIScrollView *)scrollView;
#pragma mark - 显示提示框
- (void)tishi:(NSString *)title;
#pragma mark - 结束编辑状态
- (void)endEditing;
@end
