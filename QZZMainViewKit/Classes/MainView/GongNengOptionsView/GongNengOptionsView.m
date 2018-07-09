//
//  GongNengOptionsView.m
//  
//
//  Created by qinzhongzeng on 2016/10/26.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import "GongNengOptionsView.h"
#import "HomeOptionsBtnCell.h"

@interface GongNengOptionsView  ()<UICollectionViewDelegate,UICollectionViewDataSource,HomeOptionsBtnCellDelegate>

@end

static NSString *identifier = @"HomeOptionsBtnCellID";

@implementation GongNengOptionsView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self settingCollectionView];
    }
    return self;
}

- (void)settingCollectionView{
    self.delegate = self;
    self.dataSource = self;
    [self registerNib:[UINib nibWithNibName:@"HomeOptionsBtnCell" bundle:[NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"QZZMainViewKit.bundle"]]] forCellWithReuseIdentifier:identifier];
//    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    self.backgroundColor = [UIColor whiteColor];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeOptionsBtnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (indexPath.row < self.dataArray.count) {
        
        OptionButtonModel *model = self.dataArray[indexPath.row];
        cell.model = model;
    }
    cell.delegate = self;
    cell.key = indexPath;
    return cell;
}

#pragma mark - HomeOptionsBtnCellDelegate
- (void)selectedThisOption:(NSIndexPath *)key{

    if ([self.selectedDelegate respondsToSelector:@selector(optionBtnSelected:)]) {
        [self.selectedDelegate optionBtnSelected:key];
    }
}
#pragma mark - 懒加载
- (void)setDataArray:(NSMutableArray *)dataArray{

    _dataArray = dataArray;
    [self reloadData];
}
@end
