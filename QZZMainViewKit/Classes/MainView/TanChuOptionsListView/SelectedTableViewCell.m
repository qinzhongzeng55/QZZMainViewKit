//
//  SelectedTableViewCell.m
//  
//
//  Created by qinzhongzeng on 16/7/29.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import "SelectedTableViewCell.h"

@interface SelectedTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *moreImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleWContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHContraint;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UITextView *contentText;
@end

@implementation SelectedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.moreImageView.image = [UIImage qzz_imagePathWithName:@"gotoOtherView" bundle:@"QZZMainViewKit" targetClass:[self class]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews{
    [super layoutSubviews];
    UIFontDescriptor *ctfFont = self.contentText.font.fontDescriptor;
    NSNumber *fontString = [ctfFont objectForKey:@"NSFontSizeAttribute"];
    CGFloat margin = (self.contentView.frame.size.height - [fontString integerValue]-20)*0.5;
    if ([fontString integerValue] > 17) {
        self.contentText.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        self.contentText.contentInset = UIEdgeInsetsMake(margin, 0, -margin, 0);
    }
}
#pragma mark - 点击弹出选择框
- (IBAction)selectedBtnDidClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(selectedBtnDidClick:key:)]) {
        [self.delegate selectedBtnDidClick:self.model key:self.key];
    }
}
#pragma mark - 设置标题的SIZE
- (void)settingTitleSize:(CGSize)size{
    self.titleWContraint.constant = size.width;
    self.titleHContraint.constant = size.height;
    [self layoutIfNeeded];
}
#pragma mark - 隐藏>
- (void)hiddenMoreImageView:(BOOL)isHidden{
    self.moreImageView.hidden = isHidden;
}
#pragma mark - 设置>图片
- (void)settingMoreImageView:(UIImage *)image{
    self.moreImageView.image = image;
}
#pragma mark - 隐藏底部的line
- (void)hiddenLineView:(BOOL)isHidden{
    self.lineView.hidden = isHidden;
}
#pragma mark - 设置lineView的背景颜色
- (void)settingLineViewColor:(UIColor *)color{
    self.lineView.backgroundColor = color;
}
#pragma mark - 设置标题左侧的距离
- (void)settingTitleLeft:(CGFloat)left{
    self.titleLConstraint.constant = left;
    [self layoutIfNeeded];
}
#pragma mark - 设置标题的字体
- (void)settingTitleColor:(UIColor *)color font:(UIFont *)font{
    self.titleLabel.textColor = color;
    self.titleLabel.font = font;
}
#pragma mark - 设置内容的字体
- (void)settingContentTextColor:(UIColor *)color font:(UIFont *)font{
    self.contentText.textColor = color;
    self.contentText.font = font;
}
#pragma mark - 隐藏选择按钮
- (void)hiddenSelectedBtn:(BOOL)isHidden{
    self.selectedBtn.hidden = isHidden;
}
#pragma mark - setter,getter
- (void)setModel:(TableViewCellModel *)model{
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"%@:  ",model.lableTitle];
    if (model.info == nil || [model.info isEqualToString:@""] || [model.info isKindOfClass:[NSNull class]]) {
        
        if (model.placeHoled == nil || [model.placeHoled isEqualToString:@""]) {
            //self.contentText.text = @"请选择";
        }else{
            self.contentText.text = model.placeHoled;
        }
        self.contentText.textColor = [UIColor colorWithWhite:200/255.0 alpha:1];
    }else{
        self.contentText.text = model.info;
        self.contentText.textColor = [UIColor colorWithWhite:102/255.0 alpha:1];
    }
}

- (void)setIsDetail:(BOOL)isDetail{
    
    _isDetail = isDetail;
    self.moreImageView.hidden = isDetail;
    self.selectedBtn.hidden = isDetail;
}
@end
