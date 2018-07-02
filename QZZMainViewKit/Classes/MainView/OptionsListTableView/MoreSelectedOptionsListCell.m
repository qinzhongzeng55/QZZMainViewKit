//
//  MoreSelectedOptionsListCell.m
//  
//
//  Created by 秦忠增 on 2018/5/8.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import "MoreSelectedOptionsListCell.h"

@interface MoreSelectedOptionsListCell ()

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@end

@implementation MoreSelectedOptionsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
#pragma mark - 设置选中按钮的图片
- (void)settingImage:(UIImage *)img withSelectedImage:(UIImage *)selectedImg{
    [self.selectedBtn setImage:img forState:UIControlStateNormal];
    [self.selectedBtn setImage:selectedImg forState:UIControlStateSelected];
}
#pragma mark - setter,getter
- (void)setModel:(OptionButtonModel *)model{
    _model = model;
    self.contentLabel.text = model.optionBtnLabel;
}
- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    self.selectedBtn.selected = isSelected;
}
@end
