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
#pragma mark - setter,getter
- (void)setModel:(OptionButtonModel *)model{

    _model = model;
    self.OptionImageView.image = [UIImage imageNamed:model.optionBtnImageName];
    self.OptionTextLabel.text = model.optionBtnLabel;
}
///设置标题颜色
- (void)settingTitleColor:(UIColor *)color{
    self.OptionTextLabel.textColor = color;
}
///设置标题字体
- (void)settingTitleFont:(UIFont *)font{
    self.OptionTextLabel.font = font;
}
@end
