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

- (void)settingTitleText:(NSString *)title{

    self.TitleTextLabel.text = title;
}

- (void)settingColorOfTopLineView:(UIColor *)color{
    self.TopLineView.backgroundColor = color;
}

- (void)settingColorOfQueDingBtn:(UIColor *)color{
    [self.queDingBtn setTitleColor:color forState:UIControlStateNormal];
}
@end
