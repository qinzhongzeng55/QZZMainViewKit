//
//  KuanTextViewAllDataCell.h
//  Pods
//
//  Created by 秦忠增 on 2018/7/17.
//

#import <UIKit/UIKit.h>
#import <QZZPublicModel/TableViewCellModel.h>
#import "QZZMainViewKit.h"

@interface KuanTextViewAllDataCell : UITableViewCell

@property (nonatomic, strong) TableViewCellModel *model;
@property (nonatomic, assign) UIColor *color;
@property (nonatomic, strong) NSIndexPath *key;

///设置标题字体及字体颜色
- (void)settingTitleColor:(UIColor *)color font:(UIFont *)font;
///设置内容文字
- (void)settingContentTextColor:(UIColor *)color font:(UIFont *)font;
///设置lineView的背景颜色
- (void)settingLineViewColor:(UIColor *)color;
///设置lineView高度
- (void)settinglineViewHeigth:(CGFloat)height;
///隐藏顶部的lineView
- (void)hiddenLineView;
///隐藏titleLabel
- (void)hiddenTitleLabel;
///是否显示文本框边框
- (void)showContentViewBorder:(BOOL)isShow;
///设置文本框边距
- (void)settingContentTextViewConstantForTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;
///设置文本框外边距
- (void)settingContainViewConstantForTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;
///设置标题边距
- (void)settingTitleLabelConstantForTop:(CGFloat)top left:(CGFloat)left height:(CGFloat)height;
@end
