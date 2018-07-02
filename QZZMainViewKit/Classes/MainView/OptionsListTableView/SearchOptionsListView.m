//
//  SearchOptionsListView.m
//  
//
//  Created by qinzhongzeng on 16/7/27.
//  Copyright © 2016年 qinzhongzeng. All rights reserved.
//

#import "SearchOptionsListView.h"

@interface SearchOptionsListView ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,OptionsListTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UIControl *shadeView;
@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containViewHeight;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *topView;

///是否搜索
@property (nonatomic, assign) BOOL isSearch;
///搜索结果数据
@property (nonatomic, strong) NSMutableArray *searchResultArray;
@end

@implementation SearchOptionsListView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    [self.shadeView addTarget:self action:@selector(endEdit) forControlEvents:UIControlEventTouchUpInside];
    //设置圆角
    self.containView.layer.cornerRadius = 3;
    self.containView.layer.masksToBounds = YES;
    //设置搜索框的样式
    [self settingSearchBarStyle];
    //设置tableView
    [self settingTableView];
    self.searchBar.delegate = self;
}
#pragma mark - OptionsListTableViewCellDelegate
//选中该选项
- (void)selectedThisOption:(NSIndexPath *)key{

    NSMutableArray *resultArray = self.dataArray;
    if (self.isSearch) {
        resultArray = self.searchResultArray;
    }
    OptionButtonModel *model = resultArray[key.row];
    if (self.OptionSelectedBlock) {
        self.OptionSelectedBlock(model,self.key);
    }
    [self removeFromSuperview];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.isSearch){
        return self.searchResultArray.count;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"OptionListCell";
    OptionsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = QZZGetNibFile_SecondaryBundle(@"QZZMainViewKit",@"OptionsListTableViewCell");
    }
    NSMutableArray *array = self.dataArray;
    if(self.isSearch){
        array = self.searchResultArray;
    }
    if (indexPath.row < array.count) {
        OptionButtonModel *model = array[indexPath.row];
        cell.model = model;
    }
    if(indexPath.row == array.count-1){
        [cell hiddenLineView:YES];
    }
    cell.delegate = self;
    cell.key = indexPath;
    cell.selectedBackgroundView = [UIView new];
    return cell;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self endEditing:YES];
    [self searchWithKeyText:searchBar.text];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self endEditing:YES];
    [self searchWithKeyText:searchBar.text];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
   
    [self searchWithKeyText:searchText];
}
#pragma mark - 根据关键字搜索
- (void)searchWithKeyText:(NSString *)text{
    NSString *searchText = allTrim(text);
    DLog(@"搜索: ->%@",searchText);
    NSMutableArray *tempArray = [NSMutableArray array];
    if (self.dataArray.count <= 0 || [searchText isEqualToString:@""]) {
        self.isSearch = NO;
        [self.tableView reloadData];
        return;
    }
    self.isSearch = YES;
    //搜索数据
    for (OptionButtonModel *model in self.dataArray) {
        if ([model.optionBtnLabel containsString:searchText]) {
            [tempArray addObject:model];
        }
    }
    self.searchResultArray = tempArray;
    [self.tableView reloadData];
}
#pragma mark - 设置搜索框的样式
- (void)settingSearchBarStyle{
    UITextField * searchField = [self.searchBar valueForKey:@"_searchField"];
    [searchField setValue:[UIColor colorWithWhite:204/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [searchField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    [self.searchBar setImage:[UIImage qzz_imagePathWithName:@"nav_search" bundle:@"QZZMainViewKit" targetClass:[self class]] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    self.searchBar.showsScopeBar = NO;
    self.searchBar.scopeBarBackgroundImage = [UIImage new];
}
#pragma mark - method
- (void)endEdit{
    
    [self removeFromSuperview];
}
#pragma mark - 设置tableView
- (void)settingTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 54;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark - 设置头部lineView的背景颜色
- (void)settingBackgroundColorOfTopView:(UIColor *)color{
    self.topView.backgroundColor = color;
}
#pragma mark - 懒加载
- (void)setDataArray:(NSMutableArray *)dataArray{

    _dataArray = dataArray;
    CGFloat h = self.tableView.rowHeight * dataArray.count;
    CGFloat maxH = 0;
    if (Screen_Height > 480) {
        maxH = 480;
    }else{
        maxH = 320;
    }
    if (h >= maxH) {
        h = maxH;
    }
    self.containViewHeight.constant = h + 40;
    [self.tableView reloadData];
}

- (void)setSearchResultArray:(NSMutableArray *)searchResultArray{
    _searchResultArray = searchResultArray;
    CGFloat h = self.tableView.rowHeight * searchResultArray.count;
    CGFloat maxH = 0;
    if (Screen_Height > 480) {
        maxH = 480;
    }else{
        maxH = 320;
    }
    if (h >= maxH) {
        h = maxH;
    }
    self.containViewHeight.constant = h + 40;
    [self.tableView reloadData];
}

- (void)setSearchPlaceholder:(NSString *)searchPlaceholder{
    _searchPlaceholder = searchPlaceholder;
    self.searchBar.placeholder = searchPlaceholder;
}
@end
