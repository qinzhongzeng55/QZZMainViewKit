//
//  QZZListViewController.h
//
//
//  Created by qinzhongzeng on 16/8/22.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//
#import "QZZBasicViewController.h"
#import "NavSearchBarView.h"

@interface QZZListViewController : QZZBasicViewController <UITableViewDelegate,UITableViewDataSource>

///数据列表数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
///数据列表
@property (nonatomic, strong) UITableView *tableView;
///是否过滤
@property (nonatomic, assign) BOOL isGuolv;
///无数据页面
@property (nonatomic, strong) UIView *EmptyContentView;
///新建按钮
@property (nonatomic, strong) UIButton *gotoAddBtn;
///刷新按钮
@property (nonatomic, strong) UIButton *refreshBtn;
///加载失败页面
@property (nonatomic, strong) UIView *errorView;
///回到顶部按钮
@property (nonatomic, strong) UIButton *gotoTopBtn;
///导航栏上的搜索框
@property (nonatomic, strong) NavSearchBarView *navSearchBarView;
///动态显示列表项时的样式
@property (nonatomic, assign) XSTableViewAnimationType animationType;
///导航栏的返回按钮
@property (nonatomic, strong) UIButton *navBackBtn;

#pragma mark - 加载子控件
- (void)guolv;
- (void)loadRefresh;
//  ==================注释说明====================
//                      ||
//                      ||
//                      ||
//                     \\//
//                      \/
//  覆盖以下方法修改控件的frame,覆盖前请先调用父类的方法
//  =============================================
///搜索框
- (void)loadSearchBar;
///选项列表页面
- (void)loadOptionsBtnView;
///列表容器
- (void)loadOptionListView;
///数据列表
- (void)loadOptionsListTableView;
///底部工具条
- (void)loadBottomToolBar;
///过滤选项
- (void)loadFilterOptionsView;
#pragma mark - 快捷功能视图
///加载快捷功能视图
- (void)loadKuaiJieCaoZuoView;
///回到顶部
- (void)gotoTopBtnDidClick;
///滚动超过一屏时显示回到顶部按钮
- (void)showGotoTopBtn:(UIScrollView *)scrollView;
#pragma mark - 导航栏
///点击返回按钮时的回调
- (void)backItemDidClick;
///设置导航栏
- (void)setupNavType;
///加载导航栏上的搜索框
- (void)setupNavSearchBar;
///设置搜索框左右两侧的间距
- (void)settingSearchBarLRConstratint:(CGFloat)constraint;
///设置导航栏的背景图片
- (void)settingNavBgImage:(UIImage *)bgImage;
///设置导航栏投影图片
- (void)settingNavShadowImage:(UIImage *)shadowImage;
///清除导航栏上的阴影图片
- (void)clearNavShadowImage;
///清除导航栏的背景图片
- (void)clearNavBgImage;
///设置导航栏的返回按钮是否是白的
- (void)settingLightNavBackBtn:(BOOL)isLight;
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
///设置空页面的大小
- (void)settingEmptyContentViewFrame:(CGRect)frame;
#pragma mark - 加载失败时的页面
///加载加载失败时的页面
- (void)setupGetErrorView;
//设置是否隐藏加载失败时的页面
- (void)hiddenGetError:(BOOL)isHidden;
///设置加载失败时的背景视图的背景图片
- (void)settingBgImgWithImgNameOfErrorView:(NSString *)imgName;
///重新加载数据
- (void)refreshBtnLoad;
///重新布局失败时的页面
- (void)layoutSubviewsForGetErrorView;
///设置失败时页面的大小
- (void)settingErrorViewFrame:(CGRect)frame;
#pragma mark - 动态显示列表项
- (void)starAnimationWithTableView:(UITableView *)tableView;
#pragma mark - 显示提示框
- (void)tishi:(NSString *)title;
#pragma mark - 结束编辑状态
- (void)endEditing;
@end
