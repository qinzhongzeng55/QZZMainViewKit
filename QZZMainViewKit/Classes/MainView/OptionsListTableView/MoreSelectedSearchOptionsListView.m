//
//  MoreSelectedSearchOptionsListView.m
//  
//
//  Created by 秦忠增 on 2018/5/8.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import "MoreSelectedSearchOptionsListView.h"

@interface MoreSelectedSearchOptionsListView ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,MoreSelectedOptionsListCellDelegate>

@property (weak, nonatomic) IBOutlet UIControl *shadeView;
@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containViewHeight;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *queDingBtn;

@property (nonatomic, strong) NSMutableArray *selectedArray;
@property (nonatomic, strong) UIImage *normalSelectedBtnImage;
@property (nonatomic, strong) UIImage *selectedBtnImage;
@end

@implementation MoreSelectedSearchOptionsListView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    self.selectedArray = [NSMutableArray array];
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
#pragma mark - MoreSelectedOptionsListCellDelegate
//选中该选项
- (void)selectedThisOption:(NSIndexPath *)key{
    if ([self.selectedArray containsObject:key]) {
        [self.selectedArray removeObject:key];
    }else{
        [self.selectedArray addObject:key];
    }
    [self.tableView reloadData];
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
    MoreSelectedOptionsListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = QZZGetNibFile_SecondaryBundle(@"QZZMainViewKit",@"MoreSelectedOptionsListCell");
    }
    NSMutableArray *array = self.dataArray;
    if(self.isSearch){
        array = self.searchResultArray;
    }
    if (indexPath.row < array.count) {
        OptionButtonModel *model = array[indexPath.row];
        cell.model = model;
    }
    if(indexPath.row == self.dataArray.count-1){
        [cell hiddenLineView:YES];
    }
    cell.delegate = self;
    cell.key = indexPath;
    [cell settingImage:self.normalSelectedBtnImage withSelectedImage:self.selectedBtnImage];
    cell.isSelected = [self.selectedArray containsObject:indexPath];
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
    //清空选中的indexPath
    self.selectedArray = [NSMutableArray array];
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
#pragma mark - 设置选中按钮的图片
- (void)settingImage:(UIImage *)img withSelectedImage:(UIImage *)selectedImg{
    self.normalSelectedBtnImage = img;
    self.selectedBtnImage = selectedImg;
    [self.tableView reloadData];
}
- (IBAction)confrimBtnDidClick:(id)sender {
    if (self.OptionSelectedBlock) {
        self.OptionSelectedBlock(self.selectedArray,self.key);
    }
    [self removeFromSuperview];
}
#pragma mark - 设置头部lineView的背景颜色
- (void)settingBackgroundColorOfTopView:(UIColor *)color{
    self.topView.backgroundColor = color;
}
#pragma mark - 设置确定按钮的字体颜色
- (void)settingBackgroundColorOfQueDingBtn:(UIColor *)color{
    self.queDingBtn.backgroundColor = color;
}
#pragma mark - 设置tableView
- (void)settingTableView{
    self.tableView.rowHeight = 54;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    self.containViewHeight.constant = h + 95;
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
    self.containViewHeight.constant = h + 95;
    [self.tableView reloadData];
}
- (void)setSearchPlaceholder:(NSString *)searchPlaceholder{
    _searchPlaceholder = searchPlaceholder;
    self.searchBar.placeholder = searchPlaceholder;
}
@end
