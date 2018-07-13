//
//  KuanTextViewTableViewCell.h
//  CRMNEW
//  多行文本框
//  Created by qinzhongzeng on 16/7/29.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QZZPublicModel/TableViewCellModel.h>

@protocol KuanTextViewTableViewCellDelegate <NSObject>

@optional
///多行文本框结束编辑
- (void)endEdittingWithIndexPath:(NSIndexPath *)key withModel:(TableViewCellModel *)model;

@end
@interface KuanTextViewTableViewCell : UITableViewCell

@property (nonatomic, assign) id<KuanTextViewTableViewCellDelegate> delegate;
@property (nonatomic, assign) BOOL isEditting;
@property (nonatomic, strong) TableViewCellModel *model;
@property (nonatomic, assign) UIColor *color;
@property (nonatomic, strong) NSIndexPath *key;

///最大字数
@property (nonatomic, assign) NSInteger maxLengtn;
///设置标题字体及字体颜色
- (void)settingTitleColor:(UIColor *)color font:(UIFont *)font;
///设置占位文字
- (void)settingPlaceHolderColor:(UIColor *)color font:(UIFont *)font;
///是否隐藏字数label
- (void)hiddenTextLengthLabel:(BOOL)isHidden;
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
///设置文本框外上边距
- (void)settingContainViewConstantForTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;
///设置占位文字上边距
- (void)settingPlaceHolderTConstraint:(CGFloat)constraint;
///设置占位文字左边距
- (void)settingPlaceHolderLConstraint:(CGFloat)constraint;
///设置标题上边距
- (void)settingTitleLabelTConstraint:(CGFloat)constraint;
///设置标题左边距
- (void)settingTitleLabelLConstraint:(CGFloat)constraint;
@end
