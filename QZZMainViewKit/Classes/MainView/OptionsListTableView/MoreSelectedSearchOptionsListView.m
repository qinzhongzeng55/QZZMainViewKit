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

@property (nonatomic, strong) UIImage *normalSelectedBtnImage;
@property (nonatomic, strong) UIImage *selectedBtnImage;
@property (nonatomic, assign) CGFloat selectedBtnLeft;
@property (nonatomic, assign) CGFloat selectedBtnWidth;
@property (nonatomic, strong) UIColor *optionsTitleColor;
@property (nonatomic, strong) UIFont *optionsTitleFont;
@property (nonatomic, strong) UIColor *lineViewColor;
@property (weak, nonatomic) IBOutlet UILabel *TiShiLabel;

@end

@implementation MoreSelectedSearchOptionsListView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    self.selectedNamesArray = [NSMutableArray array];
    self.selectedValuesArray = [NSMutableArray array];
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
    OptionButtonModel *model = self.dataArray[key.row];
    if (self.isSearch) {
        model = self.searchResultArray[key.row];
    }
    if ([self.selectedValuesArray containsObject:model.optionValue]) {
        [self.selectedValuesArray removeObject:model.optionValue];
    }else{
        [self.selectedValuesArray addObject:model.optionValue];
    }
    if ([self.selectedNamesArray containsObject:model.optionBtnLabel]) {
        [self.selectedNamesArray removeObject:model.optionBtnLabel];
    }else{
        [self.selectedNamesArray addObject:model.optionBtnLabel];
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
    
    static NSString *identifier = @"MoreSelectedOptionsListCellID";
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
        if ([self.selectedValuesArray containsObject:model.optionValue]) {
            cell.isSelected = YES;
        }else{
            cell.isSelected = NO;
        }
        cell.model = model;
    }
    if(indexPath.row == self.dataArray.count-1){
        [cell hiddenLineView:YES];
    }
    cell.delegate = self;
    cell.key = indexPath;
    [cell settingImage:self.normalSelectedBtnImage withSelectedImage:self.selectedBtnImage];
    [cell settingSelectedBtnLeft:(self.selectedBtnLeft == 0 ? 10 : self.selectedBtnLeft)];
    [cell settingSelectedBtnWidth:(self.selectedBtnWidth == 0 ? 44 : self.selectedBtnWidth)];
    [cell settingContentTextColor:(self.optionsTitleColor == nil ? QZZUIColorWithHexStringNoTransparent(@"#333333") : self.optionsTitleColor) font:(self.optionsTitleFont == nil ? [UIFont systemFontOfSize:17] : self.optionsTitleFont)];
    [cell settingLineViewColor:(self.lineViewColor == nil ? QZZUIColorWithHexStringNoTransparent(@"#EEEEEE") : self.lineViewColor)];
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
        self.TiShiLabel.hidden = YES;
        [self layoutContainView];
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
    for (UIView *subView in self.searchBar.subviews){
        for (UIView *secondLevelSubview in subView.subviews){
            if ([secondLevelSubview isKindOfClass:[UITextField class]]){
                UITextField *searchBarTextField = (UITextField *)secondLevelSubview;
                //placeHolder文字设置
                searchBarTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.searchBar.placeholder attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName : [UIColor colorWithWhite:204/255.0 alpha:1]}];
                break;
            }
        }
    }
    [self.searchBar setImage:[UIImage qzz_imagePathWithName:@"nav_search" bundle:@"QZZMainViewKit" targetClass:[self class]] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    self.searchBar.showsScopeBar = NO;
    self.searchBar.scopeBarBackgroundImage = [UIImage new];
}
#pragma mark - method
- (void)endEdit{
    
    [self endEditing:YES];
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
        self.OptionSelectedBlock(self.selectedNamesArray,self.selectedValuesArray,self.key);
    }
    [self removeFromSuperview];
}
#pragma mark - 设置头部View的背景颜色
- (void)settingBackgroundColorOfTopView:(UIColor *)color{
    self.topView.backgroundColor = color;
    self.searchBar.barTintColor = color;
}
#pragma mark - 设置确定按钮的背景颜色
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
#pragma mark - 设置lineView的颜色
- (void)settingLineViewColor:(UIColor *)color{
    self.lineViewColor = color;
    [self.tableView reloadData];
}
#pragma mark - 设置选中按钮左侧的距离
- (void)settingSelectedBtnLeft:(CGFloat)left{
    self.selectedBtnLeft = left;
    [self.tableView reloadData];
}
#pragma mark - 设置选中按钮的大小
- (void)settingSelectedBtnWidth:(CGFloat)width{
    self.selectedBtnWidth = width;
    [self.tableView reloadData];
}
#pragma mark - 设置选项的字体
- (void)settingContentTextColor:(UIColor *)color font:(UIFont *)font{
    self.optionsTitleColor = color;
    self.optionsTitleFont = font;
    [self.tableView reloadData];
}
#pragma mark - 懒加载
- (void)setDataArray:(NSMutableArray *)dataArray{
    
    _dataArray = dataArray;
    [self layoutContainView];
}
- (void)layoutContainView{
    CGFloat h = self.tableView.rowHeight * self.dataArray.count;
    CGFloat maxH = 0;
    CGFloat bottom = 0;
    if (self.dataArray.count == 0) {
        bottom = 50;
    }
    if (Screen_Height > 480) {
        maxH = 360;
    }else{
        maxH = 320;
    }
    if (h >= maxH) {
        h = maxH;
    }
    self.containViewHeight.constant = h + 95 + bottom;
    [self.tableView reloadData];
}
- (void)setSearchResultArray:(NSMutableArray *)searchResultArray{
    _searchResultArray = searchResultArray;
    self.TiShiLabel.hidden = searchResultArray.count > 0;
    CGFloat h = self.tableView.rowHeight * searchResultArray.count;
    CGFloat maxH = 0;
    CGFloat bottom = 0;
    if (searchResultArray.count == 0) {
        bottom = 40;
    }
    if (Screen_Height > 480) {
        maxH = 360;
    }else{
        maxH = 320;
    }
    if (h >= maxH) {
        h = maxH;
    }
    self.containViewHeight.constant = h + 95 + bottom;
    [self.tableView reloadData];
}
- (void)setSearchPlaceholder:(NSString *)searchPlaceholder{
    _searchPlaceholder = searchPlaceholder;
    self.searchBar.placeholder = searchPlaceholder;
}
- (void)setSelectedValuesArray:(NSMutableArray *)selectedValuesArray{
    _selectedValuesArray = selectedValuesArray;
    [self.tableView reloadData];
}
#pragma mark - 设置提示信息
- (void)settingTiShi:(NSString *)tiShi{
    self.TiShiLabel.text = tiShi;
}
@end
