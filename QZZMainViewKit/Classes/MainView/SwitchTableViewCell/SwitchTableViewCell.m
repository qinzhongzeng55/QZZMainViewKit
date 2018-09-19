//
//  SwitchTableViewCell.m
//
//
//  Created by qinzhongzeng on 16/7/29.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import "SwitchTableViewCell.h"

@interface SwitchTableViewCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHConstraint;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@end

@implementation SwitchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - 开关值改变回调
- (IBAction)switchValueChanged:(id)sender {
    if ([self.delegate respondsToSelector:@selector(switchValueChanged:isOn:)]) {
        [self.delegate switchValueChanged:self.key isOn:self.switchBtn.isOn];
    }
}
#pragma mark - 设置选项标题
- (void)settingOptionTitle:(NSString *)title{
    self.titleLabel.text = title;
}
#pragma mark - 隐藏底部的lineView
- (void)hiddenLineView:(BOOL)isHidden{
    self.lineView.hidden = isHidden;
}
#pragma mark - 设置lineView的背景颜色
- (void)settingLineViewColor:(UIColor *)color{
    self.lineView.backgroundColor = color;
}
#pragma mark - 设置标题左侧的距离
- (void)settingTitleLeft:(CGFloat)left height:(CGFloat)height{
    self.titleLConstraint.constant = left;
    self.titleHConstraint.constant = height;
    [self layoutIfNeeded];
}
#pragma mark - 设置标题的字体
- (void)settingTitleColor:(UIColor *)color font:(UIFont *)font{
    self.titleLabel.textColor = color;
    self.titleLabel.font = font;
}
@end
