//
//  QZZDatePickerView.h
//
//
//  Created by qinzhongzeng on 2016/12/19.
//  Copyright © 2016年 qinzhongzeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, QZZDatePickerMode) {
    QZZDatePickerModeNomal,          //2017-11-19
    QZZDatePickerModeYear,           //2017
    QZZDatePickerModeYearAndMonth    //2017-11
    
};

@protocol QZZDatePickerDelegate;


@interface QZZDatePickerView : UIView

@property (nonatomic, readonly) QZZDatePickerMode type;

@property (nonatomic, copy) NSString *time;
/** 月 */
@property (nonatomic, copy) NSString *month;
/** 年 */
@property (nonatomic,copy) NSString *year;
/** datepicker */
@property (nonatomic, strong) UIDatePicker *datePickerView;
/** pickerview */
@property (nonatomic, strong) UIPickerView *datePicker;
///是否是横屏
@property (nonatomic, assign) BOOL isLandScape;
///按钮字体颜色
@property (nonatomic, strong) UIColor *tinColor;
///按钮字体
@property (nonatomic, strong) UIFont *tinfont;

@property (weak, nonatomic) id<QZZDatePickerDelegate> delegate;

+ (instancetype)pickerViewWithType:(QZZDatePickerMode)type;

- (instancetype)initWithFrame:(CGRect)frame type:(QZZDatePickerMode)type;

- (void)show;

- (void)dismiss;

- (void)showAnimated:(BOOL)animated;

- (void)dismissAnimated:(BOOL)animated;

@end


@protocol QZZDatePickerDelegate <NSObject>

- (void)QZZDatePickerViewDidDismissWithConfirm:(QZZDatePickerView *)pickerView string:(NSString *)string;

@optional
- (void)QZZDatePickerViewDidDismissWithCancel:(QZZDatePickerView *)pickerView;

@end


