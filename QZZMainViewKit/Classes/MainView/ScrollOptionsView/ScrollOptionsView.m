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

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UIView *scrollLineView;
@property (nonatomic, strong) UIScrollView *lineContainScrollView;

@property (nonatomic, strong) UIColor *optionsTitleColor;
@property (nonatomic, strong) UIColor *optionsTitleSelecteColor;
@property (nonatomic, strong) UIFont *optionsTitleFont;
@property (nonatomic, strong) UIFont *optionsTitleSelectedFont;
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
    [self.collectionView reloadData];
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
    [cell settingTextFont:(self.optionsTitleFont == nil ? [UIFont systemFontOfSize:17] : self.optionsTitleFont) withSelectedFont:(self.optionsTitleSelectedFont == nil ? [UIFont systemFontOfSize:17] : self.optionsTitleSelectedFont)];
    return cell;
}
#pragma mark - UICollectionViewDelegate
//设置item的大小
//item的默认大小：50*50
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.lineWidth == 0) {
        self.lineWidth = self.maxWidth;
    }
    CGFloat itemH = self.itemHeight == 0 ? 48 : self.itemHeight;
    return CGSizeMake(self.lineWidth+2*self.lineMargin, itemH);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat h = self.lineHeight == 0 ? 2 : self.lineHeight;
    self.lineContainScrollView.contentSize = CGSizeMake(self.collectionView.contentSize.width, h);
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
        W = self.lineWidth+10;
    }
    if (self.selectedKey != nil) {
        CGFloat h = self.lineHeight == 0 ? 2 : self.lineHeight;
        if (key != self.selectedKey) {
            CGFloat w = self.lineWidth*0.2;
            self.scrollLineView.frame = CGRectMake(self.lineMargin+self.lineMargin*self.selectedKey.item*2+self.lineWidth*self.selectedKey.item, 0, w, h);
            self.selectedKey = key;
        }
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.65 animations:^{
            weakSelf.scrollLineView.frame = CGRectMake(self.lineWidth*self.selectedKey.item+self.lineMargin+self.lineMargin*self.selectedKey.item*2, 0, weakSelf.lineWidth, h);
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
        if (self.lineWidth == 0){
            self.lineWidth = self.maxWidth;
        }
        CGFloat h = self.lineHeight == 0 ? 2 : self.lineHeight;
        self.scrollLineView.frame = CGRectMake(self.lineWidth*self.selectedKey.item+self.lineMargin+self.lineMargin*self.selectedKey.item*2, 0, self.lineWidth, h);
        self.lineContainScrollView.contentSize = CGSizeMake(self.flowLayout.itemSize.width * self.dataArray.count, h);
        self.lineContainScrollView.frame = CGRectMake(0, self.itemHeight, Screen_Width, h);
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

#pragma mark - 设置选项颜色
- (void)settingOptionTitleColor:(UIColor *)color selectedColor:(UIColor *)selectedColor font:(UIFont *)font{
    self.optionsTitleFont = font;
    self.optionsTitleColor = color;
    self.optionsTitleSelecteColor = selectedColor;
    [self settingMaxWidth];
    [self.collectionView reloadData];
}
#pragma mark - 设置选项字体
- (void)settingTextFont:(UIFont *)font withSelectedFont:(UIFont *)selectedFont{
    self.optionsTitleFont = font;
    self.optionsTitleSelectedFont = selectedFont;
    [self settingMaxWidth];
    [self.collectionView reloadData];
}
#pragma mark - 获取最大宽度
- (void)settingMaxWidth{
    for (NSString *title in self.dataArray) {
        UIFont *contentFont = self.optionsTitleFont == nil ? [UIFont systemFontOfSize:17] : self.optionsTitleFont;
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
#pragma mark - 设置lineContainView背景颜色
- (void)settingLineContainViewBGColor:(UIColor *)bgColor{
    self.lineContainScrollView.backgroundColor = bgColor;
}
#pragma mark - 设置lineView背景颜色
- (void)settingLineViewBGColor:(UIColor *)bgColor{
    self.lineView.backgroundColor = bgColor;
}
#pragma mark - 隐藏lineView
- (void)hiddenLineView{
    self.lineView.hidden = YES;
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
    [self.collectionView scrollToItemAtIndexPath:selectedKey atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
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
    CGFloat h = self.lineHeight == 0 ? 2 : self.lineHeight;
    self.scrollLineView.frame = CGRectMake(x, 0, self.lineWidth, h);
}
- (UIView *)scrollLineView{
    if (_scrollLineView == nil) {
        UIView *lineView = [[UIView alloc] init];
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
