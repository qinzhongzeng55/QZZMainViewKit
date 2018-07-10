//
//  ScrollOptionsView.m
//  WQYL_SYS
//
//  Created by 秦忠增 on 2018/4/23.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import "ScrollOptionsView.h"
#import "ScrollOptionsCell.h"

@interface ScrollOptionsView ()<UICollectionViewDelegate,UICollectionViewDataSource,ScrollOptionsCellDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UIView *scrollLineView;
@property (nonatomic, strong) UIScrollView *lineContainScrollView;

@property (nonatomic, strong) UIColor *optionsTitleColor;
@property (nonatomic, strong) UIFont *optionsTitleFont;
@end

static NSString *identifier = @"ScrollOptionsCellID";

@implementation ScrollOptionsView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self settingCollectionView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat W = 0;
    if (self.dataArray.count > 4) {
        W = Screen_Width*0.25;
    }else{
        W = Screen_Width/self.dataArray.count;
    }
    if (self.lineWidth == 0) {
        self.lineWidth = W;
    }
    self.flowLayout.itemSize = CGSizeMake(W, self.bounds.size.height);
    self.lineContainScrollView.frame = CGRectMake(0, self.bounds.size.height-3, Screen_Width, 2);
    self.scrollLineView.frame = CGRectMake((W-self.lineWidth)*0.5, 0, self.lineWidth, 2);
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ScrollOptionsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (indexPath.item < self.dataArray.count) {
        [cell settingTitleLabelText:self.dataArray[indexPath.item]];
    }
    cell.key = indexPath;
    cell.delegate = self;
    //设置是否被选中
    [cell settingSelectedForOptionBtn:self.selectedKey == indexPath];
    [cell settingOptionTitleColor:(self.optionsTitleColor == nil ? QZZUIColorWithHexStringNoTransparent(@"#333333") : self.optionsTitleColor) font:(self.optionsTitleFont == nil ? [UIFont systemFontOfSize:17] : self.optionsTitleFont)];
    return cell;
}
#pragma mark - UICollectionViewDelegate
//设置item的大小
//item的默认大小：50*50
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count > 3) {
        
        return CGSizeMake(self.lineWidth, 48);
    }
    return CGSizeMake(Screen_Width/self.dataArray.count, 48);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.lineContainScrollView.contentSize = CGSizeMake(self.collectionView.contentSize.width, 2);
    
    self.lineContainScrollView.contentOffset = self.collectionView.contentOffset;
}
#pragma mark - ScrollOptionsCellDelegate
///选择这个选项(放大滑动效果)
- (void)selectedThisOption:(NSIndexPath *)key{
    CGFloat W = 0;
    if (self.dataArray.count > 3) {
        W = Screen_Width/3;
    }else{
        W = Screen_Width/self.dataArray.count;
    }
    if (self.lineWidth != 0) {
        W = self.lineWidth;
    }
    if (self.selectedKey != nil) {
        if (key != self.selectedKey) {
            CGFloat w = self.lineWidth*0.2;
            self.scrollLineView.frame = CGRectMake((self.selectedKey.item+2)*((W-self.lineWidth)*0.5)+self.selectedKey.item*self.lineWidth+self.lineWidth*0.4, 0, w, 2);
            self.selectedKey = key;
        }
        CGFloat x = 0;
        if (key.item == 0) {
            x = (W-self.lineWidth)*0.5;
        }else{
            x = (key.item+2)*((W-self.lineWidth)*0.5)+key.item*self.lineWidth;
        }
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.65 animations:^{
            weakSelf.scrollLineView.frame = CGRectMake(x, 0, weakSelf.lineWidth, 2);
        }];
    }else{
        self.selectedKey = key;
    }
    [self.collectionView reloadData];
    if ([self.delegate respondsToSelector:@selector(selectedThisOption:)]) {
        [self.delegate selectedThisOption:key];
    }
}
#pragma mark - 实现滑动下划线
- (void)setupScrollLineView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 47, Screen_Width, 2)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    CGFloat W = 0;
    if (self.dataArray.count > 3) {
        W = Screen_Width/3;
    }else{
        W = Screen_Width/self.dataArray.count;
    }
    if (self.lineWidth == 0) {
        self.lineWidth = W;
    }
    UIView *lineView= [[UIView alloc] initWithFrame:CGRectMake((W-self.lineWidth)*0.5, 0, self.lineWidth, 2)];
    lineView.layer.cornerRadius = 1;
    lineView.layer.masksToBounds = YES;
    lineView.backgroundColor = self.lineColor == nil ? QZZUIColorWithRGB(58, 156, 241) : self.lineColor;
    [scrollView addSubview:lineView];
    scrollView.contentSize = CGSizeMake(W * self.dataArray.count, 2);
    self.scrollLineView =  lineView;
    self.lineContainScrollView = scrollView;
    [self.contentView addSubview:scrollView];
}
///滚动到指定的列
- (void)scrollToIndexPath:(NSIndexPath *)key{
    [self.collectionView scrollToItemAtIndexPath:key atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}
#pragma mark - settingCollectionView
- (void)settingCollectionView{
    
    //默认选中第一个
    self.selectedKey = [NSIndexPath indexPathForItem:0 inSection:0];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ScrollOptionsCell" bundle:[NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"QZZMainViewKit.bundle"]]] forCellWithReuseIdentifier:identifier];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.bounces = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    //设置滚动视图布局对象
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
}
#pragma mark - 设置选项字体
- (void)settingOptionTitleColor:(UIColor *)color font:(UIFont *)font{
    self.optionsTitleFont = font;
    self.optionsTitleColor = color;
    [self.collectionView reloadData];
}
#pragma mark - setter,getter
- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [self settingCollectionView];
    [self setupScrollLineView];
}

- (void)setSelectedKey:(NSIndexPath *)selectedKey{
    _selectedKey = selectedKey;
    [self selectedThisOption:selectedKey];
    [self.collectionView reloadData];
}
@end
