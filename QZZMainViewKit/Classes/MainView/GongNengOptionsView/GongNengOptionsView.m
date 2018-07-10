//
//  GongNengOptionsView.m
//  
//
//  Created by qinzhongzeng on 2016/10/26.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import "GongNengOptionsView.h"
#import "SelectedOptionsBtnCell.h"

@interface GongNengOptionsView  ()<UICollectionViewDelegate,UICollectionViewDataSource,SelectedOptionsBtnCellDelegate>

///功能按钮的图片的宽度
@property (nonatomic, assign) CGFloat imgViewWidthOfOptionsBtn;
@property (nonatomic, strong) UIFont *labelFont;
@property (nonatomic, assign) CGFloat labelTop;
@property (nonatomic, assign) CGFloat titlelabelHeight;
@end

static NSString *identifier = @"SelectedOptionsBtnCellID";

@implementation GongNengOptionsView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.imgViewWidthOfOptionsBtn = frame.size.height - 34;
        self.labelFont = [UIFont systemFontOfSize:17];
        self.labelTop = 1;
        [self settingCollectionView];
    }
    return self;
}

- (void)settingCollectionView{
    self.delegate = self;
    self.dataSource = self;
    [self registerNib:[UINib nibWithNibName:@"SelectedOptionsBtnCell" bundle:[NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"QZZMainViewKit.bundle"]]] forCellWithReuseIdentifier:identifier];
//    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    self.backgroundColor = [UIColor whiteColor];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectedOptionsBtnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (indexPath.row < self.dataArray.count) {
        
        OptionButtonModel *model = self.dataArray[indexPath.row];
        cell.model = model;
    }
    [cell settingImageViewWidth:self.imgViewWidthOfOptionsBtn];
    [cell settingLabelFont:self.labelFont];
    [cell settingTitleLabelTop:self.labelTop];
    [cell settingTitlelabelHeight:self.titlelabelHeight];
    cell.delegate = self;
    cell.key = indexPath;
    return cell;
}

#pragma mark - SelectedOptionsBtnCellDelegate
- (void)selectedThisOption:(NSIndexPath *)key{

    if ([self.selectedDelegate respondsToSelector:@selector(optionBtnSelected:)]) {
        [self.selectedDelegate optionBtnSelected:key];
    }
}
//设置功能按钮的图片的宽度(长度 1:1)
- (void)settingImageViewWidthOfOptionsBtn:(CGFloat)width{
    self.imgViewWidthOfOptionsBtn = width;
    [self reloadData];
}
///设置功能按钮的font
- (void)settingLabelFontOfOptionsBtn:(UIFont *)font{
    self.labelFont = font;
    [self reloadData];
}
///设置文本头部距离
- (void)settingTitleLabelTopOfOptionsBtn:(CGFloat)top{
    self.labelTop = top;
    [self reloadData];
}
///设置文本高度
- (void)settingTitlelabelHeight:(CGFloat)height{
    self.titlelabelHeight = height;
    [self reloadData];
}
#pragma mark - 懒加载
- (void)setDataArray:(NSMutableArray *)dataArray{

    _dataArray = dataArray;
    [self reloadData];
}
@end
