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
@property (nonatomic, strong) UIColor *optionsTitleSelecteColor;
@property (nonatomic, strong) UIFont *optionsTitleFont;
@property (nonatomic, assign) CGFloat maxWidth;
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
    if (self.lineWidth == 0) {
        self.lineWidth = self.maxWidth;
    }
    self.flowLayout.itemSize = CGSizeMake(self.lineWidth, self.bounds.size.height);
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ScrollOptionsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = QZZGetNibFile_SecondaryBundle(@"QZZMainViewKit", @"ScrollOptionsCell");
    }
    if (indexPath.item < self.dataArray.count) {
        [cell settingTitleLabelText:self.dataArray[indexPath.item]];
    }
    cell.key = indexPath;
    cell.delegate = self;
    //设置是否被选中
    [cell settingSelectedForOptionBtn:self.selectedKey == indexPath];
    [cell settingOptionTitleColor:(self.optionsTitleColor == nil ? QZZUIColorWithHexStringNoTransparent(@"#333333") : self.optionsTitleColor) selectedColor:(self.optionsTitleSelecteColor == nil ? QZZUIColorWithHexStringNoTransparent(@"#333333") : self.optionsTitleSelecteColor) font:(self.optionsTitleFont == nil ? [UIFont systemFontOfSize:17] : self.optionsTitleFont)];
    return cell;
}
#pragma mark - UICollectionViewDelegate
//设置item的大小
//item的默认大小：50*50
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.lineWidth == 0) {
        self.lineWidth = self.maxWidth;
    }
    return CGSizeMake(self.lineWidth, 48);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.lineContainScrollView.contentSize = CGSizeMake(self.collectionView.contentSize.width, 2);
    
    self.lineContainScrollView.contentOffset = self.collectionView.contentOffset;
}
#pragma mark - ScrollOptionsCellDelegate
///选择这个选项(放大滑动效果)
- (void)selectedThisOption:(NSIndexPath *)key{
    [self showScrollLineView:key];
    if ([self.delegate respondsToSelector:@selector(selectedThisOption:)]) {
        [self.delegate selectedThisOption:key];
    }
}
- (void)showScrollLineView:(NSIndexPath *)key{
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
}
#pragma mark - 实现滑动下划线
- (void)setupScrollLineView{
    if (self.dataArray.count > 0) {
        CGFloat W = 0;
        if (self.dataArray.count > 4) {
            W = Screen_Width*0.25;
        }else{
            W = Screen_Width/self.dataArray.count;
        }
        CGFloat x = W-self.lineWidth;
        if (x < 0) {
            x = 0;
        }
        self.scrollLineView.frame = CGRectMake(x*0.5, 0, self.lineWidth, 2);
        self.lineContainScrollView.contentSize = CGSizeMake(W * self.dataArray.count, 2);
        [self.contentView addSubview:self.lineContainScrollView];
    }
}
///滚动到指定的列
- (void)scrollToIndexPath:(NSIndexPath *)key{
    self.selectedKey = key;
    [self showScrollLineView:key];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.collectionView scrollToItemAtIndexPath:key atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    });
}
#pragma mark - settingCollectionView
- (void)settingCollectionView{
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
- (void)settingOptionTitleColor:(UIColor *)color selectedColor:(UIColor *)selectedColor font:(UIFont *)font{
    self.optionsTitleFont = font;
    self.optionsTitleColor = color;
    self.optionsTitleSelecteColor = selectedColor;
    [self settingMaxWidth];
    [self.collectionView reloadData];
}
#pragma mark - 获取最大宽度
- (void)settingMaxWidth{
    for (NSString *title in self.dataArray) {
        UIFont *contentFont = self.optionsTitleFont;
        CGSize contentTextMaxSize = CGSizeMake(Screen_Width,48);
        CGSize size = [[AutomaticSizeTools sharedAutomaticSizeTools] boundingALLRectWithSize:title Font:contentFont MaxSize:contentTextMaxSize LineSpacing:kWebLineSpacing WordsSpacing:kWebWordsSpacing];
        if (self.maxWidth == 0) {
            self.maxWidth = size.width+12;
        }else{
            if (size.width > self.maxWidth) {
                self.maxWidth = size.width+12;
            }
        }
    }
}
#pragma mark - setter,getter
- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [self settingMaxWidth];
    [self.collectionView reloadData];
    //默认选中第一个
    self.selectedKey = [NSIndexPath indexPathForItem:0 inSection:0];
    [self setupScrollLineView];
    
}

- (void)setSelectedKey:(NSIndexPath *)selectedKey{
    _selectedKey = selectedKey;
    [self.collectionView reloadData];
}
- (void)setLineWidth:(CGFloat)lineWidth{
    _lineWidth = lineWidth;
    CGFloat x = 0;
    if (self.selectedKey.item == 0) {
        x = 0;
    }else{
        x = self.selectedKey.item*self.lineWidth;
    }
    self.scrollLineView.frame = CGRectMake(x, 0, self.lineWidth, 2);
}
- (UIView *)scrollLineView{
    if (_scrollLineView == nil) {
        UIView *lineView= [[UIView alloc] init];
        lineView.layer.cornerRadius = 1;
        lineView.layer.masksToBounds = YES;
        lineView.backgroundColor = self.lineColor == nil ? QZZUIColorWithRGB(58, 156, 241) : self.lineColor;
        _scrollLineView = lineView;
        [self.lineContainScrollView addSubview:_scrollLineView];
    }
    return _scrollLineView;
}
- (UIScrollView *)lineContainScrollView{
    if (_lineContainScrollView == nil) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 47, Screen_Width, 2)];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        _lineContainScrollView = scrollView;
    }
    return _lineContainScrollView;
}
@end
