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
