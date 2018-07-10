//
//  MoreSelectedTableViewCell.m
//  
//
//  Created by qinzhongzeng on 16/7/29.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import "MoreSelectedTableViewCell.h"

@interface MoreSelectedTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentText;
@property (weak, nonatomic) IBOutlet UIImageView *moreImgView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleWConstraint;
@property (weak, nonatomic) IBOutlet UIButton *gotoDetailBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLConstraint;

@end

@implementation MoreSelectedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.moreImgView.image = [UIImage qzz_imagePathWithName:@"gotoOtherView" bundle:@"QZZMainViewKit" targetClass:[self class]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)gotoSelected:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(moreSelectedBtnDidClick:key:)]) {
        [self.delegate moreSelectedBtnDidClick:self.model key:self.key];
    }
}
#pragma mark - 设置底部的line
- (void)hiddenLineView:(BOOL)isHidden{
    self.lineView.hidden = isHidden;
}
#pragma mark - 设置lineView的背景颜色
- (void)settingLineViewColor:(UIColor *)color{
    self.lineView.backgroundColor = color;
}
#pragma mark - 设置标题的宽度
- (void)settingTitleWidth:(CGFloat)width{
    self.titleWConstraint.constant = width;
}
#pragma mark - 设置标题左侧的距离
- (void)settingTitleLeft:(CGFloat)left{
    self.titleLConstraint.constant = left;
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
#pragma mark - 隐藏 >
- (void)hiddenMoreImageView:(BOOL)isHidden{
    self.moreImgView.hidden = isHidden;
}
#pragma mark - 设置>图片
- (void)settingMoreImageView:(UIImage *)image{
    self.moreImgView.image = image;
}
#pragma mark - setter,getter
- (void)setModel:(TableViewCellModel *)model{

    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"%@:  ",model.lableTitle];
    if (model.info == nil || [model.info isEqualToString:@""] || [model.info isKindOfClass:[NSNull class]]) {
        
        if (model.placeHoled == nil || [model.placeHoled isEqualToString:@""]) {
//            self.contentText.text = @"请选择";
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
    self.moreImgView.hidden = isDetail;
    self.gotoDetailBtn.hidden = isDetail;
}
@end
