//
//  SelectedTableViewCell.h
//  
//
//  Created by qinzhongzeng on 16/7/29.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QZZMainViewKit.h"

@protocol SelectedTableViewCellDelegate <NSObject>

@optional
- (void)selectedBtnDidClick:(TableViewCellModel *)model key:(NSIndexPath *)key;

@end

@interface SelectedTableViewCell : UITableViewCell

@property (nonatomic, assign) id<SelectedTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *key;
@property (nonatomic, strong) TableViewCellModel *model;
///占位文字颜色
@property (nonatomic, strong) UIColor *placeholderColor;
///占位文字字体
@property (nonatomic, strong) UIFont *placeholderFont;
///内容文本颜色
@property (nonatomic, strong) UIColor *contentTextColor;
///内容字体
@property (nonatomic, strong) UIFont *contentTextFont;

///隐藏lineView
- (void)hiddenLineView:(BOOL)isHidden;
///设置lineView的背景颜色
- (void)settingLineViewColor:(UIColor *)color;
///设置>图片
- (void)settingMoreImageView:(UIImage *)image;
///设置>图片size
- (void)settingMoreImageSize:(CGSize)size;
///隐藏 >
- (void)hiddenMoreImageView:(BOOL)isHidden;
///设置标题的SIZE
- (void)settingTitleSize:(CGSize)size;
///设置标题左侧的距离
- (void)settingTitleLeft:(CGFloat)left;
///设置标题的字体
- (void)settingTitleColor:(UIColor *)color font:(UIFont *)font;
///隐藏选择按钮
- (void)hiddenSelectedBtn:(BOOL)isHidden;
@end
