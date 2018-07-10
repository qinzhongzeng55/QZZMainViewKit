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
@property (weak, nonatomic) IBOutlet UIImageView *IconImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgLConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgWConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TitleLConstraint;
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
- (void)settingTitleView:(NSString *)title font:(UIFont *)font{
    self.TitleLabel.text = title;
    self.TitleLabel.font = font;
}
#pragma mark - 设置图片大小
- (void)settingImageWidth:(CGFloat)width{
    self.imgWConstraint.constant = width;
}
#pragma mark - 设置图片左侧距离
- (void)settingImageLeft:(CGFloat)left{
    self.imgLConstraint.constant = left;
}
#pragma mark - 设置文本左侧距离
- (void)settingTitleLeft:(CGFloat)left{
    self.TitleLConstraint.constant = left;
}
#pragma mark - 是否显示图片
- (void)showImageView:(BOOL)isShow{
    self.IconImageView.hidden = !isShow;
    if (!isShow) {
        
        self.imgWConstraint.constant = 0;
        self.TitleLConstraint.constant = 0;
    }
}
#pragma mark - 设置图片
- (void)settingImageView:(UIImage *)image{
    self.IconImageView.image = image;
}
#pragma mark - 设置lineView的背景颜色
- (void)settingLineViewColor:(UIColor *)color{
    self.lineView.backgroundColor = color;
}

@end
