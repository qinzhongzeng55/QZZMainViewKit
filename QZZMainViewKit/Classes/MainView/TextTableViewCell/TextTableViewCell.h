//
//  TextTableViewCell.h
//
//
//  Created by qinzhongzeng on 16/7/29.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QZZMainViewKit.h"

@protocol TextTableViewCellDelegate <NSObject>

@optional
- (void)endEdittingWithModel:(TableViewCellModel *)model key:(NSIndexPath *)key;

@end
@interface TextTableViewCell : UITableViewCell

@property (nonatomic, assign) id<TextTableViewCellDelegate> delegate;
@property (nonatomic, strong) TableViewCellModel *model;
@property (nonatomic, strong) NSIndexPath *key;
///最大字数
@property (nonatomic, assign) NSInteger maxCount;
///占位文字颜色
@property (nonatomic, strong) UIColor *placeholderColor;
///占位文字字体
@property (nonatomic, strong) UIFont *placeholderFont;
///内容文本颜色
@property (nonatomic, strong) UIColor *contentTextColor;
///内容字体
@property (nonatomic, strong) UIFont *contentTextFont;


- (void)resignResponder;
///设置弹出键盘类型
- (void)settingKeyboardType:(UIKeyboardType)KeyboardType;
///设置lineView左边距
- (void)settingLineLConstraint:(CGFloat)width;
///设置标题左边距
- (void)settingTitleLConstraint:(CGFloat)left;
///设置标题的SIZE
- (void)settingTitleSize:(CGSize)size;
///隐藏lineView
- (void)hiddenLineView:(BOOL)isHidden;
///设置lineView的背景颜色
- (void)settingLineViewColor:(UIColor *)color;
///设置标题的字体
- (void)settingTitleColor:(UIColor *)color font:(UIFont *)font;
///设置内容的字体
- (void)settingContentTextColor:(UIColor *)color font:(UIFont *)font;
@end
