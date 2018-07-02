//
//  TextTableViewCell.h
//  
//
//  Created by qinzhongzeng on 16/7/29.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QZZPublicModel/TableViewCellModel.h>

@protocol TextTableViewCellDelegate <NSObject>

@optional
- (void)endEdittingWithModel:(TableViewCellModel *)model key:(NSIndexPath *)key;

@end
@interface TextTableViewCell : UITableViewCell

@property (nonatomic, assign) id<TextTableViewCellDelegate> delegate;
@property (nonatomic, strong) TableViewCellModel *model;
@property (nonatomic, assign) UIColor *color;
@property (nonatomic, assign) BOOL isDetail;
@property (nonatomic, strong) NSIndexPath *key;

- (void)resignResponder;
///设置文本内容颜色
- (void)settingContentTextColor:(UIColor *)color;
///设置弹出键盘类型
- (void)settingKeyboardType:(UIKeyboardType)KeyboardType;
///设置lineView左边距
- (void)settingLineLConstraint:(CGFloat)width;
///设置标题左边距
- (void)settingTitleLConstraint:(CGFloat)width;
///设置标题宽度
- (void)settingTitleWidth:(CGFloat)width;
///隐藏lineView
- (void)hiddenLineView:(BOOL)isHidden;
@end
