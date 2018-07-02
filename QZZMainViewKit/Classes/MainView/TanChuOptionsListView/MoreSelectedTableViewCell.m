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
#pragma mark - 设置标题的宽度
- (void)settingTitleWidth:(CGFloat)width{
    self.titleWConstraint.constant = width;
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
- (void)setColor:(UIColor *)color{

    self.titleLabel.textColor = color;
}
- (void)setIsDetail:(BOOL)isDetail{
    
    _isDetail = isDetail;
    self.moreImgView.hidden = isDetail;
    self.gotoDetailBtn.hidden = isDetail;
}
@end
