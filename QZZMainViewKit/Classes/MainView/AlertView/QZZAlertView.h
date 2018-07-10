//
//  QZZAlertView.h
//
//  确认框/警告框
//  Created by qinzhongzeng on 2017/2/17.
//  Copyright © 2017年 bejingyimeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QZZAlertViewDelegate <NSObject>

@optional
///点击确定时的回调
- (void)queDing;
///点击取消时的回调
- (void)cancle;
@end

@interface QZZAlertView : UIView

@property (nonatomic, assign) id<QZZAlertViewDelegate> delegate;

///设置警告框内容
- (void)settingTitleText:(NSString *)title font:(UIFont *)font;
///设置头部lineView的背景颜色
- (void)settingColorOfTopLineView:(UIColor *)color;
///设置确定按钮的字体颜色
- (void)settingColorOfQueDingBtn:(UIColor *)color;
///设置确定按钮
- (void)settingQueDingBtnTitle:(NSString *)title font:(UIFont *)font;
@end
