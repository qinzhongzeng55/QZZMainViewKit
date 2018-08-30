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
@property (nonatomic, copy) NSString *str111;
/** 年 */
@property (nonatomic,copy) NSString *str222;
/** datepicker */
@property (nonatomic, strong) UIDatePicker *datePickerView;
/** pickerview */
@property (nonatomic, strong) UIPickerView *datePicker;

@property (weak, nonatomic) id<QZZDatePickerDelegate> delegate;

+ (instancetype)pickerViewWithType:(QZZDatePickerMode)type;

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


