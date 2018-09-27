//
//  SwitchTableViewCell.h
//
//
//  Created by qinzhongzeng on 16/7/29.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SwitchTableViewCellDelegate <NSObject>

@optional
///开关值改变回调
- (void)switchValueChanged:(NSIndexPath *)key withSwitch:(UISwitch *)switchBtn;

@end

@interface SwitchTableViewCell : UITableViewCell

@property (nonatomic, assign) id<SwitchTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *key;

///设置开关
- (void)settingSwitchOn:(BOOL)isOn;
///设置选项标题
- (void)settingOptionTitle:(NSString *)title;
///隐藏lineView
- (void)hiddenLineView:(BOOL)isHidden;
///设置lineView的背景颜色
- (void)settingLineViewColor:(UIColor *)color;
///设置标题左侧的距离
- (void)settingTitleLeft:(CGFloat)left height:(CGFloat)height;
///设置标题的字体
- (void)settingTitleColor:(UIColor *)color font:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
