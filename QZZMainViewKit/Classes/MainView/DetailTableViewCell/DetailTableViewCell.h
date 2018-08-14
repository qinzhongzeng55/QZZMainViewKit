//
//  DetailTableViewCell.h
//
//
//  Created by qinzhongzeng on 16/7/29.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QZZMainViewKit.h"

@interface DetailTableViewCell : UITableViewCell

@property (nonatomic, strong) TableViewCellModel *model;
@property (nonatomic, strong) NSIndexPath *key;
///标题文字颜色
@property (nonatomic, strong) UIColor *titleColor;
///内容文本颜色
@property (nonatomic, strong) UIColor *contentTextColor;

///设置lineView左边距
- (void)settingLineLConstraint:(CGFloat)left;
///设置标题左边距
- (void)settingTitleLConstraint:(CGFloat)left;
///设置标题右边距
- (void)settingTitleRConstraint:(CGFloat)right;
///隐藏lineView
- (void)hiddenLineView:(BOOL)isHidden;
///设置lineView的背景颜色
- (void)settingLineViewColor:(UIColor *)color;
///设置内容的字体
- (void)settingContentFont:(UIFont *)font;
@end
