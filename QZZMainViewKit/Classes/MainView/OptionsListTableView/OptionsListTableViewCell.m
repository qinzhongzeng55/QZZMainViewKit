//
//  OptionsListTableViewCell.m
//  
//
//  Created by 秦忠增 on 2018/4/19.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import "OptionsListTableViewCell.h"

@interface OptionsListTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *optionContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *moreImageView;
@end

@implementation OptionsListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.moreImageView.image = [UIImage qzz_imagePathWithName:@"gotoOtherView" bundle:@"QZZMainViewKit" targetClass:[self class]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - 选中该选项时的回调
- (IBAction)selectedThisOption:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectedThisOption:)]) {
        [self.delegate selectedThisOption:self.key];
    }
}
#pragma mark - 隐藏底部line
- (void)hiddenLineView:(BOOL)isHidden{
    self.lineView.hidden = isHidden;
}
#pragma mark - 隐藏显示更多view
- (void)hiddenMoreImageView:(BOOL)isHidden{
    self.moreImageView.hidden = isHidden;
}
#pragma mark - 设置lineView的颜色
- (void)settingLineViewColor:(UIColor *)color{
    self.lineView.backgroundColor = color;
}
#pragma mark - 设置选项的字体
- (void)settingContentTextColor:(UIColor *)color font:(UIFont *)font{
    self.optionContentLabel.textColor = color;
    self.optionContentLabel.font = font;
}
#pragma mark - setter,getter
- (void)setModel:(OptionButtonModel *)model{
    _model = model;
    self.optionContentLabel.text = model.optionBtnLabel;
}
@end
