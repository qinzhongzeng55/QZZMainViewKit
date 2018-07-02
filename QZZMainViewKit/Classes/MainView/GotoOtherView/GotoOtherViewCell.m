//
//  GotoOtherViewCell.m
//  WQYL_SYS
//
//  Created by 秦忠增 on 2018/4/20.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import "GotoOtherViewCell.h"

@interface GotoOtherViewCell ()

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *gotoOtherViewImageView;
@end

@implementation GotoOtherViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.gotoOtherViewImageView.image = [UIImage qzz_imagePathWithName:@"gotoOtherView" bundle:@"QZZMainViewKit" targetClass:[self class]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 跳转到别的页面
- (IBAction)gotoOtherView:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(gotoOtherView:)]) {
        [self.delegate gotoOtherView:self.key];
    }
}
#pragma mark - 隐藏底部的line
- (void)hiddenLineView:(BOOL)isHidden{
    self.lineView.hidden = isHidden;
}
#pragma mark - 设置选项文本
- (void)settingTitleView:(NSString *)title{
    self.TitleLabel.text = title;
}
@end
