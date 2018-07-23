//
//  KuanTextViewTableViewCell.h
//  CRMNEW
//  多行文本框
//  Created by qinzhongzeng on 16/7/29.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QZZPublicModel/TableViewCellModel.h>
#import "QZZMainViewKit.h"

@protocol KuanTextViewTableViewCellDelegate <NSObject>

@optional
///多行文本框结束编辑
- (void)endEdittingWithIndexPath:(NSIndexPath *)key withModel:(TableViewCellModel *)model;

@end
@interface KuanTextViewTableViewCell : UITableViewCell

@property (nonatomic, assign) id<KuanTextViewTableViewCellDelegate> delegate;
@property (nonatomic, assign) BOOL isEditting;
@property (nonatomic, strong) TableViewCellModel *model;
@property (nonatomic, strong) NSIndexPath *key;
///最大字数
@property (nonatomic, assign) NSInteger maxLengtn;

///设置标题内容颜色
- (void)settingTitleColor:(UIColor *)color;
///设置占位文字颜色
- (void)settingPlaceHolderColor:(UIColor *)color;
///设置字体大小
- (void)settingFontSize:(CGFloat)size;
///是否隐藏字数label
- (void)hiddenTextLengthLabel:(BOOL)isHidden;
///隐藏lineView
- (void)hiddenLineView;
///隐藏titleLabel
- (void)hiddenTitleLabel;
///是否显示文本框边框
- (void)showContentViewBorder:(BOOL)isShow;
///设置文本框下边距
- (void)settingContentTextViewBConstraint:(CGFloat)constraint;
///设置占位文字上边距
- (void)settingPlaceHolderTConstraint:(CGFloat)constraint;
@end
