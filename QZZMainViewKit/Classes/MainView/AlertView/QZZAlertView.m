//
//  QZZAlertView.m
//  
//
//  Created by qinzhongzeng on 2017/2/17.
//  Copyright © 2017年 bejingyimeng. All rights reserved.
//

#import "QZZAlertView.h"

@interface QZZAlertView()
@property (weak, nonatomic) IBOutlet UIButton *cacleBtn;
@property (weak, nonatomic) IBOutlet UIButton *queDingBtn;
@property (weak, nonatomic) IBOutlet UIView *TopLineView;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UILabel *TitleTextLabel;
@end

@implementation QZZAlertView

- (void)awakeFromNib{

    [super awakeFromNib];
    self.alertView.layer.cornerRadius = 5;
    self.alertView.layer.masksToBounds = YES;
}

- (IBAction)cancle:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cancle)]) {
        [self.delegate cancle];
    }
    [self removeFromSuperview];
}

- (IBAction)queDing:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(queDing)]) {
        [self.delegate queDing];
    }
    [self removeFromSuperview];
}

- (IBAction)removeView:(id)sender {
    [self removeFromSuperview];
}
//设置警告框内容
- (void)settingTitleText:(NSString *)title font:(UIFont *)font{

    self.TitleTextLabel.text = title;
    self.TitleTextLabel.font = font;
}
//设置确定按钮
- (void)settingQueDingBtnTitle:(NSString *)title font:(UIFont *)font{
    [self.queDingBtn setTitle:title forState:UIControlStateNormal];
    self.queDingBtn.titleLabel.font = font;
}
 //设置头部lineView的背景颜色
- (void)settingColorOfTopLineView:(UIColor *)color{
    self.TopLineView.backgroundColor = color;
}
//设置确定按钮的字体颜色
- (void)settingColorOfQueDingBtn:(UIColor *)color{
    [self.queDingBtn setTitleColor:color forState:UIControlStateNormal];
}
@end
