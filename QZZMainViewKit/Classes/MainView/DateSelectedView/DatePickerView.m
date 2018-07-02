//
//  DatePickerView.m
//  
//
//  Created by qinzhongzeng on 16/7/26.
//  Copyright © 2016年 qinzhongzeng. All rights reserved.
//

#import "DatePickerView.h"

@interface DatePickerView ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *dateSelecterView;
@property (weak, nonatomic) IBOutlet UIControl *shadeView;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UIView *topView;

@end
@implementation DatePickerView

- (void)awakeFromNib{

    [super awakeFromNib];
    [self.shadeView addTarget:self action:@selector(endEdit) forControlEvents:UIControlEventTouchUpInside];
    self.dateSelecterView.layer.cornerRadius = 5;
    self.dateSelecterView.layer.masksToBounds  = YES;
}

- (IBAction)selectedDate:(id)sender {
    if (self.selectedDateBlock) {
        self.selectedDateBlock(self.datePicker.date);
    }
    [self endEdit];
}

- (void)endEdit{

    [self removeFromSuperview];
}
#pragma mark - 日期选择器设置
- (void)settingDatePickerMode:(UIDatePickerMode)mode{

    self.datePicker.datePickerMode = mode;
}

- (void)settingMinDate:(NSDate *)minimumDate{

    self.datePicker.minimumDate = minimumDate;
}

- (void)settingMaxDate:(NSDate *)maxDate{
    
    self.datePicker.maximumDate = maxDate;
}
#pragma mark - 设置标题
- (void)settingTitle:(NSString *)title{
    self.TitleLabel.text = title;
}
#pragma mark - 头部View的背景颜色
- (void)settingBackgroundColorOfTopView:(UIColor *)color{
    self.topView.backgroundColor = color;
}
#pragma mark - 设置选择按钮的背景颜色
- (void)settingBackgroundColorOfQueDingBtn:(UIColor *)color{
    self.selectedBtn.backgroundColor = color;
}
@end
