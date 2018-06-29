//
//  QZZBasicViewController.m
//  
//
//  Created by qinzhongzeng on 16/8/17.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import "QZZBasicViewController.h"

@interface QZZBasicViewController ()<UISearchBarDelegate>


@end

@implementation QZZBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //获取阴影视图
    self.contentLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    self.contentLineImageView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.contentLineImageView.hidden = NO;
}
#pragma mark - ********搜索框********
//#pragma mark - UISearchResultsUpdating
//-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//    NSString *searchString = [self.searchBar text];
//    self.searchString = searchString;
//    //刷新表格
//    [self updateData];
//}

- (void)updateData{}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar setShowsCancelButton:NO animated:YES];
    self.searchString = searchBar.text;
    //刷新表格
    [self updateData];
    [self.searchBar resignFirstResponder];
    [self.view endEditing:YES];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.isSearch = YES;
    [searchBar setShowsCancelButton:NO animated:YES];
    // 修改UISearchBar右侧的取消按钮文字颜色及背景图片
    for (id obj in [searchBar.subviews[0] subviews]) {
        
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            
            UIButton *cancleButton = (UIButton *)obj;
            [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
//            [cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [cancleButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
            
        }
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:NO animated:YES];
    self.searchString = @"";
    searchBar.text = @"";
    [self.searchBar resignFirstResponder];
    [self.view endEditing:YES];
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

#pragma mark - ********懒加载********
//- (UISearchController *)searchController{
//
//    if (_searchController == nil) {
//        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
//        _searchController.searchResultsUpdater = self;
//        _searchController.dimsBackgroundDuringPresentation = YES;
//        _searchController.hidesNavigationBarDuringPresentation = NO;
//        _searchController.searchBar.delegate = self;
//        _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
//    }
//    return _searchController;
//}

- (UIView *)optionsBtnView{
    
    if (_optionsBtnView == nil) {
        _optionsBtnView = [[UIView alloc] init];
    }
    return _optionsBtnView;
}
- (UIView *)bottomToolsView{
    
    if (_bottomToolsView == nil) {
        _bottomToolsView = [[UIView alloc] init];
    }
    return _bottomToolsView;
}

- (UIView *)filterOptionsView{
    
    if (_filterOptionsView == nil) {
        _filterOptionsView = [[UIView alloc] init];
    }
    return _filterOptionsView;
}

- (UIView *)optionListView{
    
    if (_optionListView == nil) {
        _optionListView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _optionListView;
}
- (UIView *)searchBarView{
    
    if (_searchBarView == nil) {
        _searchBarView = [[UIView alloc] initWithFrame:CGRectZero];
        [_searchBarView addSubview:self.searchBar];
    }
    return _searchBarView;
}

- (UISearchBar *)searchBar{
    
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"请输入关键字";
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.backgroundImage = [UIImage new];
    }
    return _searchBar;
}

- (void)setRowsCountForData:(NSInteger)RowsCountForData{
    
    _RowsCountForData = RowsCountForData;
    self.upLoadRefresh.countForData = RowsCountForData;
    self.downLoadRefresh.countForData = RowsCountForData;
}

- (void)setCurrentPage:(NSInteger)currentPage{
    
    _currentPage = currentPage;
    self.upLoadRefresh.currentPage = currentPage;
    self.downLoadRefresh.currentPage = currentPage;
}

- (void)setRowsNumInOnePage:(NSInteger)rowsNumInOnePage{
    
    _rowsNumInOnePage = rowsNumInOnePage;
    self.upLoadRefresh.rowsInOnePage = rowsNumInOnePage;
    self.downLoadRefresh.rowsInOnePage = rowsNumInOnePage;
}

- (void)setUpLoadDataBlock:(QZZRefreshUpLoadBlock)upLoadDataBlock{
    _upLoadDataBlock = upLoadDataBlock;
    self.upLoadRefresh.upLoadDataBlock = upLoadDataBlock;
}

- (void)setDownLoadDataBlock:(QZZRefreshDownLoadBlock)downLoadDataBlock{
    _downLoadDataBlock = downLoadDataBlock;
    self.downLoadRefresh.downLoadDataBlock = downLoadDataBlock;
}
#pragma mark - 设置状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    if (self.isStatusBarLight) {
        return UIStatusBarStyleLightContent;
    }else{
        return UIStatusBarStyleDefault;
    }
}
@end
