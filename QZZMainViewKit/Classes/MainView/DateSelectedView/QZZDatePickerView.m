//
//  QZZDatePickerView.m
//
//
//  Created by qinzhongzeng on 2016/12/19.
//  Copyright © 2016年 qinzhongzeng. All rights reserved.
//


#import "QZZDatePickerView.h"

const CGFloat QZZDatePickerViewBottomViewHeight = 216.0;
const CGFloat QZZDatePickerViewButtonWidth = 64.0;
const CGFloat QZZDatePickerViewButtonHeight = 35.0;

@interface QZZDatePickerView () <UIPickerViewDelegate,UIPickerViewDataSource>

/** 年份数组 */
@property (strong,nonatomic) NSMutableArray *yearArr;
/** 月份数组 */
@property (strong,nonatomic) NSMutableArray *monthArr;
/** 选择的时间 */
@property (strong,nonatomic) NSString *timeSelectedString;
@property (strong,nonatomic) NSString *yearStr;
@property (strong,nonatomic) NSString *monthStr;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) UIView *bottomView;

@end

@implementation QZZDatePickerView

- (instancetype)initWithFrame:(CGRect)frame type:(QZZDatePickerMode)type {
    self = [super initWithFrame:frame];
    
    if (self) {
        _type = type;
        
        [self setupInit];
    }
    
    return self;
}

#pragma mark - Public
+ (instancetype)pickerViewWithType:(QZZDatePickerMode)type {
    QZZDatePickerView *view = [[QZZDatePickerView alloc] initWithFrame:CGRectZero type:type];
    
    return view;
}

- (void)show {
    [self showAnimated:true];
}

- (void)showAnimated:(BOOL)animated {
    if (self.superview) {
        return;
    }
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    CGFloat bottomViewY = CGRectGetHeight([UIScreen mainScreen].bounds) - QZZDatePickerViewBottomViewHeight;
    CGRect bottomFrame = CGRectMake(0, bottomViewY, CGRectGetWidth([UIScreen mainScreen].bounds), QZZDatePickerViewBottomViewHeight);
    //
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^ {
            self.alpha = 1.0;
            self.bottomView.frame = bottomFrame;
        }];
    } else {
        _bottomView.frame = bottomFrame;
        self.alpha = 1.0;
    }
}

- (void)dismiss {
    [self dismissAnimated:true];
}

- (void)dismissAnimated:(BOOL)animated {
    
    if (animated) {
        CGRect bottomFrame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds), QZZDatePickerViewBottomViewHeight);
        
        [UIView animateWithDuration:0.3 animations:^ {
            self.alpha = 0.0;
            
            self.bottomView.frame = bottomFrame;
            
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    } else {
        [self removeFromSuperview];
    }
}

#pragma mark - Private
- (void)setupInit {
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor clearColor];
    
    self.alpha = 0.0;
    
    [self setupMainView];
    
    [self setupBottomView];
    
    //    [self setupPicker];
}

- (void)setupMainView {
    if (_mainView) {
        return;
    }
    _mainView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _mainView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25];
    _mainView.userInteractionEnabled = true;
    [self addSubview:_mainView];
    
    UITapGestureRecognizer *mainTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mainTap:)];
    [_mainView addGestureRecognizer:mainTap];
}

- (void)setupBottomView {
    if (_bottomView) {
        return;
    }
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds), QZZDatePickerViewBottomViewHeight)];
    _bottomView.backgroundColor = [UIColor grayColor];
    [_mainView addSubview:_bottomView];
    
    [self setupCancelAndConfirmButton];
}

//确定和取消按钮
- (void)setupCancelAndConfirmButton {
    
    UIColor *buttonTitleColor = [UIColor colorWithRed:0.0 green:122/255.0 blue:1.0 alpha:1.0];
    
    CGFloat x = 12;
    if (self.isLandScape) {
        x = 44;
    }
    // Cancel
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, QZZDatePickerViewButtonWidth, QZZDatePickerViewButtonHeight)];
    self.cancelButton = cancelButton;
    NSString *cancelText = @"取消";
    
    cancelButton.titleLabel.text = cancelText;
    [cancelButton setTitle:cancelText forState:UIControlStateNormal];
    [cancelButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    
    [cancelButton addTarget:self action:@selector(cancelClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // Confirm
    CGFloat confirmButtonX = CGRectGetWidth([UIScreen mainScreen].bounds) - QZZDatePickerViewButtonWidth-12;
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(confirmButtonX, 0, QZZDatePickerViewButtonWidth, QZZDatePickerViewButtonHeight)];
    NSString *confirmText = @"确定";
    self.confirmButton = confirmButton;
    confirmButton.titleLabel.text = confirmText;
    [confirmButton setTitle:confirmText forState:UIControlStateNormal];
    [confirmButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomView addSubview:cancelButton];
    [_bottomView addSubview:confirmButton];
}


//设置初始时间
- (void)setTime:(NSString *)time {
    
    if (time.length > 5) {
        _month = [time substringFromIndex:5];
        _year = [time substringToIndex:4];
    }else {
        _year = time;
    }
    
    [self setupPicker];
    
}
//
- (void)setupPicker {
    if (_type == QZZDatePickerModeNomal) {
        if (_datePicker) {
            return;
        }
        _datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, QZZDatePickerViewButtonHeight, CGRectGetWidth([UIScreen mainScreen].bounds), QZZDatePickerViewBottomViewHeight - QZZDatePickerViewButtonHeight)];
        _datePickerView.datePickerMode = UIDatePickerModeDate;
        _datePickerView.backgroundColor = [UIColor grayColor];
        [_bottomView addSubview:_datePickerView];
        
        
    } else if (_type == QZZDatePickerModeYearAndMonth) {
        if (_datePicker) {
            return;
        }
        //初始时间选择文字
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM"];
        self.monthStr = [formatter stringFromDate:[NSDate date]];
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateFormat:@"yyyy"];
        self.yearStr = [formatter1 stringFromDate:[NSDate date]];
        self.timeSelectedString = [NSString stringWithFormat:@"%@-%@",self.yearStr,self.monthStr];
        
        _datePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, QZZDatePickerViewButtonHeight, CGRectGetWidth([UIScreen mainScreen].bounds), QZZDatePickerViewBottomViewHeight - QZZDatePickerViewButtonHeight)];
        _datePicker.backgroundColor = [UIColor grayColor];
        _datePicker.dataSource = self;
        _datePicker.delegate = self;
        [_bottomView addSubview:_datePicker];
        
        int a = [_month intValue];
        int b = [_year intValue];
        [self.datePicker selectRow:a-1 inComponent:1 animated:NO];
        [self.datePicker selectRow:b-1900 inComponent:0 animated:NO];
        
        
    }else if (_type == QZZDatePickerModeYear) {
        if (_datePicker) {
            return;
        }
        
        //初始时间选择文字
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM"];
        self.monthStr = [formatter stringFromDate:[NSDate date]];
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateFormat:@"yyyy"];
        self.yearStr = [formatter1 stringFromDate:[NSDate date]];
        self.timeSelectedString = [NSString stringWithFormat:@"%@",self.yearStr];
        
        _datePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, QZZDatePickerViewButtonHeight, CGRectGetWidth([UIScreen mainScreen].bounds), QZZDatePickerViewBottomViewHeight - QZZDatePickerViewButtonHeight)];
        _datePicker.backgroundColor = [UIColor grayColor];
        _datePicker.dataSource = self;
        _datePicker.delegate = self;
        [_bottomView addSubview:_datePicker];
        
        int b = [_year intValue];
        [self.datePicker selectRow:b-1900 inComponent:0 animated:NO];
    }
}

#pragma mrak -
#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (_type == QZZDatePickerModeYearAndMonth) {
        return 2;
    }
    if (_type == QZZDatePickerModeYear) {
        return 1;
    }
    return 1;
}

#pragma mark UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        self.yearStr = self.yearArr[row];
    }else{
        self.monthStr = self.monthArr[row];
    }
    if (_type == QZZDatePickerModeYearAndMonth) {
        self.timeSelectedString = [NSString stringWithFormat:@"%@-%@",self.yearStr,self.monthStr];
    }else if (_type == QZZDatePickerModeYear) {
        self.timeSelectedString = [NSString stringWithFormat:@"%@",self.yearStr];
    }
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (_type == QZZDatePickerModeYearAndMonth) {
        if (component == 0) {
            return 400;
        }else {
            return 12;
        }
    }else if (_type == QZZDatePickerModeYear) {
        return 400;
    }
    return 0;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (_type == QZZDatePickerModeYearAndMonth) {
        if (component == 0) {
            return  self.yearArr[row];
        }else {
            return  self.monthArr[row];
        }
    }else if (_type == QZZDatePickerModeYear) {
        return  self.yearArr[row];
    }
    return @"";
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

#pragma mark - 懒加载
/**
 月份
 
 @return 月份数组
 */
-(NSMutableArray *)monthArr{
    if (!_monthArr) {
        self.monthArr = [[NSMutableArray alloc]init];
        for (int i = 1; i<13; i++) {
            NSString *str;
            if ( i < 10) {
                str = [NSString stringWithFormat:@"%02d",i];
            }else {
                str = [NSString stringWithFormat:@"%d",i];
            }
            [self.monthArr addObject:str];
        }
    }
    return _monthArr;
}

/**
 最大和最小年份
 
 @return 数组
 */
-(NSMutableArray *)yearArr{
    if (!_yearArr) {
        self.yearArr = [[NSMutableArray alloc]init];
        for (int i = 1900; i<3000; i++) {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            
            [self.yearArr addObject:str];
        }
    }
    return _yearArr;
}

#pragma mark - Selector
- (void)mainTap:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateRecognized) {
        [self dismiss];
        
        if ([_delegate respondsToSelector:@selector(QZZDatePickerViewDidDismissWithCancel:)]) {
            [_delegate QZZDatePickerViewDidDismissWithCancel:self];
        }
    }
}

//取消
- (void)cancelClicked:(UIButton *)sender {
    [self dismiss];
    
    if ([_delegate respondsToSelector:@selector(QZZDatePickerViewDidDismissWithCancel:)]) {
        [_delegate QZZDatePickerViewDidDismissWithCancel:self];
    }
}

//确定
- (void)confirmClicked:(UIButton *)sender {
    [self dismiss];
    
    if ([_delegate respondsToSelector:@selector(QZZDatePickerViewDidDismissWithConfirm:string:)]) {
        [_delegate QZZDatePickerViewDidDismissWithConfirm:self string:self.timeSelectedString];
    }
}
#pragma mark - setter,getter
- (void)setIsLandScape:(BOOL)isLandScape{
    _isLandScape = isLandScape;
    CGFloat x = 12;
    if (isLandScape) {
        if (([UIScreen mainScreen].bounds.size.width == 812.0) || ([UIScreen mainScreen].bounds.size.width == 896.0)) {
            x = 32;
        }
    }
    self.cancelButton.frame = CGRectMake(x, 0, QZZDatePickerViewButtonWidth, QZZDatePickerViewButtonHeight);
}
- (void)setTinColor:(UIColor *)tinColor{
    _tinColor = tinColor;
    [self.cancelButton setTitleColor:tinColor forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:tinColor forState:UIControlStateNormal];
}
- (void)setTinfont:(UIFont *)tinfont{
    _tinfont = tinfont;
    self.cancelButton.titleLabel.font = tinfont;
    self.confirmButton.titleLabel.font = tinfont;
}
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    _backgroundColor = backgroundColor;
    _bottomView.backgroundColor = backgroundColor;
    _datePickerView.backgroundColor = backgroundColor;
    _datePicker.backgroundColor = backgroundColor;
}
@end
