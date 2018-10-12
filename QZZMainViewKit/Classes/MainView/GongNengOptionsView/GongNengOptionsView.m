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
@property (nonatomic, assign) CGFloat labelBottom;
@property (nonatomic, assign) CGFloat titlelabelHeight;
@property (nonatomic, strong) UIColor *textColor;
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
    [cell settingImageViewWidth:(self.imgViewWidthOfOptionsBtn == 0 ? 36: self.imgViewWidthOfOptionsBtn)];
    [cell settingLabelFont:(self.labelFont == nil ? [UIFont systemFontOfSize:17] : self.labelFont)];
    [cell settingTextColor:(self.textColor == nil ? [UIColor colorWithWhite:51/255.0 alpha:1] :self.textColor)];
    [cell settingTitleLabelTop:(self.labelTop == 0 ? 5 : self.labelTop)];
    [cell settingTitleLabelBottom:(self.labelBottom == 0 ? 5 : self.labelBottom)];
    [cell settingTitlelabelHeight:(self.titlelabelHeight == 0 ? 24 : self.titlelabelHeight)];
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
#pragma mark - 设置功能按钮的图片的宽度(长度 1:1)
- (void)settingImageViewWidthOfOptionsBtn:(CGFloat)width{
    self.imgViewWidthOfOptionsBtn = width;
    [self reloadData];
}
#pragma mark - 设置功能按钮的font
- (void)settingLabelFontOfOptionsBtn:(UIFont *)font{
    self.labelFont = font;
    [self reloadData];
}
#pragma mark - 设置功能按钮的字体颜色
- (void)settingTextColorOfOptionsBtn:(UIColor *)color{
    self.textColor = color;
    [self reloadData];
}
#pragma mark - 设置文本头部距离
- (void)settingTitleLabelTopOfOptionsBtn:(CGFloat)top{
    self.labelTop = top;
    [self reloadData];
}
#pragma mark - 设置文本底部距离
- (void)settingTitleLabelBottomOfOptionsBtn:(CGFloat)bottom{
    self.labelBottom = bottom;
    [self reloadData];
}
#pragma mark - 设置文本高度
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
