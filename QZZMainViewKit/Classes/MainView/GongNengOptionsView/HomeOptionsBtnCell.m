//
//  HomeOptionsBtnCell.m
//  
//
//  Created by qinzhongzeng on 2017/1/10.
//  Copyright © 2017年 bejingyimeng. All rights reserved.
//

#import "HomeOptionsBtnCell.h"

@interface HomeOptionsBtnCell()

@property (weak, nonatomic) IBOutlet UIImageView *OptionImageView;
@property (weak, nonatomic) IBOutlet UILabel *OptionTextLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWConstraint;

@end

@implementation HomeOptionsBtnCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)gotoShowView:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectedThisOption:)]) {
        [self.delegate selectedThisOption:self.key];
    }
}
///设置图片的宽度(长度 1:1)
- (void)settingImageViewWidth:(CGFloat)width{
    self.imageViewWConstraint.constant = width;
}
///设置功能按钮的font
- (void)settingLabelFont:(UIFont *)font{
    self.OptionTextLabel.font = font;
}
#pragma mark - setter,getter
- (void)setModel:(OptionButtonModel *)model{

    _model = model;
    self.OptionImageView.image = [UIImage imageNamed:model.optionBtnImageName];
    self.OptionTextLabel.text = model.optionBtnLabel;
}
@end
