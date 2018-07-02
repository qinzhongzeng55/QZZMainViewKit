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
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UIImageView *moreImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleWContraint;

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
#pragma mark - 点击弹出选择框
- (IBAction)selectedBtnDidClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(selectedBtnDidClick:key:)]) {
        [self.delegate selectedBtnDidClick:self.model key:self.key];
    }
    if (self.selectedBtnDidClickBlock) {
        self.selectedBtnDidClickBlock(self.model);
    }
}
#pragma mark - 设置标题的宽度
- (void)settingTitleWidth:(CGFloat)width{
    self.titleWContraint.constant = width;
}
#pragma mark - 隐藏>
- (void)hiddenMoreImageView:(BOOL)isHidden{
    self.moreImageView.hidden = isHidden;
}
#pragma mark - 隐藏底部的line
- (void)hiddenLineView:(BOOL)isHidden{
    self.lineView.hidden = isHidden;
}
#pragma mark - setter,getter
- (void)setModel:(TableViewCellModel *)model{
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"%@:  ",model.lableTitle];
    if (model.info == nil || [model.info isEqualToString:@""]) {
        
        if (model.placeHoled == nil || [model.placeHoled isEqualToString:@""]) {
//            [self.selectedBtn setTitle:@"请选择" forState:UIControlStateNormal];
        }else{
            [self.selectedBtn setTitle:model.placeHoled forState:UIControlStateNormal];
        }
        [self.selectedBtn setTitleColor:[UIColor colorWithWhite:200/255.0 alpha:1] forState:UIControlStateNormal];
    }else{
        
        [self.selectedBtn setTitle:model.info forState:UIControlStateNormal];
        [self.selectedBtn setTitleColor:[UIColor colorWithWhite:102/255.0 alpha:1] forState:UIControlStateNormal];
    }
}

- (void)setIsDetail:(BOOL)isDetail{
    
    _isDetail = isDetail;
    self.moreImageView.hidden = isDetail;
    self.selectedBtn.enabled = !isDetail;
}

- (void)setColor:(UIColor *)color{
    
    self.titleLabel.textColor = color;
}
@end
