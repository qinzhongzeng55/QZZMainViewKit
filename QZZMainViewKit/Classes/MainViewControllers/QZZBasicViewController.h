//
//  QZZBasicViewController.h
//  ==================注释说明====================
//                      ||
//                      ||
//                      ||
//                     \\//
//                      \/
//  1. 去除导航栏阴影
//  2. 上拉加载/下拉刷新
//  3. 检索
//  =============================================
//  Created by qinzhongzeng on 16/8/17.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "QZZMainViewKit.h"

@interface QZZBasicViewController : UIViewController

///更新数据
- (void)updateData;
#pragma mark - 上拉加载/下拉刷新
///总行数
@property (assign, nonatomic) NSInteger RowsCountForData;
///每页数据的条数
@property (assign, nonatomic) NSInteger rowsNumInOnePage;
///当前页码
@property (assign, nonatomic) NSInteger currentPage;
///上拉加载
@property (strong, nonatomic) QZZRefresh *upLoadRefresh;
///下拉刷新
@property (strong, nonatomic) QZZRefresh *downLoadRefresh;
///上拉加载的回调
@property (copy, nonatomic) QZZRefreshUpLoadBlock upLoadDataBlock;
///下拉刷新的回调
@property (copy, nonatomic) QZZRefreshDownLoadBlock downLoadDataBlock;
#pragma mark - 去除导航栏阴影
///导航栏的阴影视图
@property (nonatomic, strong) UIImageView *contentLineImageView;
#pragma mark - 搜索框
///搜索框
//@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (copy, nonatomic) NSString *searchString;
///是否搜索
@property (assign, nonatomic) BOOL isSearch;
///导航栏上是否展开
@property (assign, nonatomic) BOOL isExpansion;
#pragma mark - 子控件
///列表视图
@property (strong, nonatomic) UIView *optionListView;
///选项卡视图
@property (strong, nonatomic) UIView *optionsBtnView;
///底部工具条
@property (strong, nonatomic) UIView *bottomToolsView;
///过滤选项视图
@property (strong, nonatomic) UIView *filterOptionsView;
///搜索框视图
@property (strong, nonatomic) UIView *searchBarView;


///设置状态栏样式是否是白色
@property (nonatomic,assign) BOOL isStatusBarLight;
///获取阴影视图
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view;

@end
