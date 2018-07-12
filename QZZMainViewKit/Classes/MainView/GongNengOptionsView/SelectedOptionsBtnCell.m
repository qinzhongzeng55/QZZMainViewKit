//
//  SelectedOptionsBtnCell.m
//  
//
//  Created by qinzhongzeng on 2017/1/10.
//  Copyright © 2017年 bejingyimeng. All rights reserved.
//

#import "SelectedOptionsBtnCell.h"

@interface SelectedOptionsBtnCell()

@property (weak, nonatomic) IBOutlet UIImageView *OptionImageView;
@property (weak, nonatomic) IBOutlet UILabel *OptionTextLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TextLabelHConstraint;
@end

@implementation SelectedOptionsBtnCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)gotoShowView:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectedThisOption:)]) {
        [self.delegate selectedThisOption:self.key];
    }
}
#pragma mark - 设置图片的宽度(长度 1:1)
- (void)settingImageViewWidth:(CGFloat)width{
    self.imageViewWConstraint.constant = width;
}
#pragma mark - 设置功能按钮的font
- (void)settingLabelFont:(UIFont *)font{
    self.OptionTextLabel.font = font;
}
#pragma mark - 设置功能按钮的字体颜色
- (void)settingTextColor:(UIColor *)color{
    self.OptionTextLabel.textColor = color;
}
#pragma mark - 设置文本头部距离
- (void)settingTitleLabelTop:(CGFloat)top{
    self.titleLabelTConstraint.constant = top;
}
#pragma mark - 设置文本高度
- (void)settingTitlelabelHeight:(CGFloat)height{
    self.TextLabelHConstraint.constant = height;
}
#pragma mark - setter,getter
- (void)setModel:(OptionButtonModel *)model{

    _model = model;
    self.OptionImageView.image = [UIImage imageNamed:model.optionBtnImageName];
    self.OptionTextLabel.text = model.optionBtnLabel;
}
@end
