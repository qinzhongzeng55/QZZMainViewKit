//
//  KuanTextViewAllDataCell.h
//  Pods
//
//  Created by 秦忠增 on 2018/7/17.
//

#import <UIKit/UIKit.h>
#import "QZZMainViewKit.h"

@protocol KuanTextViewAllDataCellDelegate <NSObject>

@optional
///多行文本框结束编辑
- (void)endEdittingWithIndexPath:(NSIndexPath *)key withModel:(TableViewCellModel *)model;
///点击回车键时的回调
- (void)returnBtnDidClick;
@end

@interface KuanTextViewAllDataCell : UITableViewCell

@property (nonatomic, assign) id<KuanTextViewAllDataCellDelegate> delegate; 
@property (nonatomic, strong) TableViewCellModel *model;
@property (nonatomic, assign) BOOL isEditting;
@property (nonatomic, strong) NSIndexPath *key;
///最大字数
@property (nonatomic, assign) NSInteger maxLengtn;

///设置标题字体及字体颜色
- (void)settingTitleColor:(UIColor *)color font:(UIFont *)font;
///设置内容文字
- (void)settingContentTextColor:(UIColor *)color font:(UIFont *)font;
///设置占位文字
- (void)settingPlaceHolderColor:(UIColor *)color font:(UIFont *)font;
///设置当前字数文本
- (void)settingCurrentNumLabelColor:(UIColor *)color font:(UIFont *)font;
///设置最大字数文本
- (void)settingMaxNumLabelColor:(UIColor *)color font:(UIFont *)font;
///是否隐藏字数label
- (void)hiddenTextLengthLabel:(BOOL)isHidden;
///设置lineView的背景颜色
- (void)settingLineViewColor:(UIColor *)color;
///设置lineView高度
- (void)settinglineViewHeigth:(CGFloat)height;
///隐藏顶部的lineView
- (void)hiddenLineView;
///隐藏底部的lineView
- (void)hiddenBottomLineView:(BOOL)isHidden;
///隐藏titleLabel
- (void)hiddenTitleLabel;
///是否显示文本框边框
- (void)showContentViewBorder:(BOOL)isShow;
///设置文本框边距
- (void)settingContentTextViewConstantForTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;
///设置文本框外边距
- (void)settingContainViewConstantForTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;
///设置占位文字边距
- (void)settingPlaceHolderConstantForTop:(CGFloat)top left:(CGFloat)left;
///设置标题边距
- (void)settingTitleLabelConstantForTop:(CGFloat)top left:(CGFloat)left height:(CGFloat)height;
@end
