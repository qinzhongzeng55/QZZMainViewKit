//
//  DatePickerView.h
//  
//  日期选择框
//  Created by qinzhongzeng on 16/7/26.
//  Copyright © 2016年 qinzhongzeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^selectedDateBlock)(NSDate *selectedDate);

@interface DatePickerView : UIView
///选择日期后的回调
@property (copy, nonatomic) selectedDateBlock selectedDateBlock;

///设置日期选择器的模式
- (void)settingDatePickerMode:(UIDatePickerMode)mode;
///设置日期选择器的最小时间
- (void)settingMinDate:(NSDate *)minimumDate;
///设置日期选择器的最大时间
- (void)settingMaxDate:(NSDate *)maxDate;
///设置标题
- (void)settingTitle:(NSString *)title;
///设置头部lineView的背景颜色
- (void)settingBackgroundColorOfTopView:(UIColor *)color;
///设置确定按钮的字体颜色
- (void)settingBackgroundColorOfQueDingBtn:(UIColor *)color;
@end
