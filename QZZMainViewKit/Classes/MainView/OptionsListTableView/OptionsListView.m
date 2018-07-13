//
//  OptionsListView.m
//  
//
//  Created by 秦忠增 on 2018/4/19.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import "OptionsListView.h"

@interface OptionsListView ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,OptionsListTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UIControl *shadeView;
@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containViewWConstraint;

@property (nonatomic, assign) BOOL isHiddenMoreImageView;
@property (nonatomic, strong) UIColor *optionsTitleColor;
@property (nonatomic, strong) UIFont *optionsTitleFont;
@property (nonatomic, strong) UIColor *lineViewColor;
@property (nonatomic, strong) UIImage *moreImage;
@end

@implementation OptionsListView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    [self.shadeView addTarget:self action:@selector(endEdit) forControlEvents:UIControlEventTouchUpInside];
    //设置圆角
    self.containView.layer.cornerRadius = 5;
    self.containView.layer.masksToBounds = YES;
    //设置tableView
    [self settingTableView];
}
#pragma mark - OptionsListTableViewCellDelegate
//选中该选项
- (void)selectedThisOption:(NSIndexPath *)key{
    
    OptionButtonModel *model = self.dataArray[key.row];
    if (self.OptionSelectedBlock) {
        self.OptionSelectedBlock(model,self.key);
    }
    [self removeFromSuperview];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"OptionListCell";
    OptionsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = QZZGetNibFile_SecondaryBundle(@"QZZMainViewKit",@"OptionsListTableViewCell");
    }
    if (indexPath.row < self.dataArray.count) {
        OptionButtonModel *model = self.dataArray[indexPath.row];
        cell.model = model;
    }
    if(indexPath.row == self.dataArray.count-1){
        [cell hiddenLineView:YES];
    }
    cell.delegate = self;
    cell.key = indexPath;
    [cell settingContentTextColor:(self.optionsTitleColor == nil ? QZZUIColorWithHexStringNoTransparent(@"#333333") : self.optionsTitleColor) font:(self.optionsTitleFont == nil ? [UIFont systemFontOfSize:17] : self.optionsTitleFont)];
    [cell settingLineViewColor:(self.lineViewColor == nil ? QZZUIColorWithHexStringNoTransparent(@"#EEEEEE") : self.lineViewColor)];
    [cell hiddenMoreImageView:self.isHiddenMoreImageView];
    [cell settingMoreImageView:self.moreImage];
    cell.selectedBackgroundView = [UIView new];
    return cell;
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
#pragma mark - 设置lineView的颜色
- (void)settingLineViewColor:(UIColor *)color{
    self.lineViewColor = color;
    [self.tableView reloadData];
}
#pragma mark - 隐藏 >
- (void)hiddenMoreImageView:(BOOL)isHidden{
    self.isHiddenMoreImageView = isHidden;
    [self.tableView reloadData];
}
#pragma mark - 设置选项的字体
- (void)settingContentTextColor:(UIColor *)color font:(UIFont *)font{
    self.optionsTitleFont = font;
    self.optionsTitleColor = color;
    [self.tableView reloadData];
}
///设置>图片
- (void)settingMoreImageView:(UIImage *)image{
    self.moreImage = image;
    [self.tableView reloadData];
}
#pragma mark - 设置弹框的字体
- (void)settingTitleColor:(UIColor *)color font:(UIFont *)font{
    self.TitleLabel.textColor = color;
    self.TitleLabel.font = font;
}
#pragma mark - 设置头部图片
- (void)settingTopImageView:(UIImage *)image{
    self.topImageView.image = image;
}
#pragma mark - 设置头部view的高度
- (void)settingTopViewHeight:(CGFloat)height{
    self.topViewHConstraint.constant = height;
}
#pragma mark - 设置containView的圆角角度
- (void)settingContainViewRadius:(CGFloat)radius{
    self.containView.layer.cornerRadius = radius;
    self.containView.layer.masksToBounds = YES;
}
#pragma mark - 设置containViewd的宽度
- (void)settingContainViewWidth:(CGFloat)Width{
    self.containViewWConstraint.constant = Width;
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

- (void)setOptionsListTitle:(NSString *)optionsListTitle{
    _optionsListTitle = optionsListTitle;
    self.TitleLabel.text = optionsListTitle;
}
@end
