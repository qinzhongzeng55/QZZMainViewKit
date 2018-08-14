//
//  DetailTableViewCell.m
//
//
//  Created by qinzhongzeng on 16/7/29.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import "DetailTableViewCell.h"

@interface DetailTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleRConstraint;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewLConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelHConstraint;

@end

@implementation DetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
#pragma mark - 设置lineView左边距
- (void)settingLineLConstraint:(CGFloat)left{
    
    self.lineViewLConstraint.constant = left;
    [self layoutIfNeeded];
}
#pragma mark - 设置标题左边距
- (void)settingTitleLConstraint:(CGFloat)left{
    
    self.titleLConstraint.constant = left;
    [self layoutIfNeeded];
}
#pragma mark - 设置标题右边距
- (void)settingTitleRConstraint:(CGFloat)right{
    self.titleRConstraint.constant = right;
    [self layoutIfNeeded];
}
#pragma mark - 隐藏lineView
- (void)hiddenLineView:(BOOL)isHidden{
    self.lineView.hidden = isHidden;
}
#pragma mark - 设置lineView的背景颜色
- (void)settingLineViewColor:(UIColor *)color{
    self.lineView.backgroundColor = color;
}
#pragma mark - 设置内容的字体
- (void)settingContentFont:(UIFont *)font{
    self.titleLabel.font = font;
}
#pragma mark - setter,getter
- (void)setModel:(TableViewCellModel *)model{
    
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"%@:%@ ",model.lableTitle,model.info];
    //自动计算文本高度
    [UILabel changeSpace:self.titleLabel withLineSpace:kWebLineSpacing WordSpace:kWebWordsSpacing];
    UIFont *titleFont = self.titleLabel.font;
    CGSize titleMaxSize = CGSizeMake(Screen_Width-self.titleLConstraint.constant-self.titleRConstraint.constant, Screen_Height);
    CGSize size = [[AutomaticSizeTools sharedAutomaticSizeTools] boundingALLRectWithSize:self.titleLabel.text Font:titleFont MaxSize:titleMaxSize LineSpacing:kWebLineSpacing WordsSpacing:kWebWordsSpacing];
    self.titleLabelHConstraint.constant = size.height;
    //设置字体颜色
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    UIColor *color = QZZUIColorWithHexStringNoTransparent(@"#333333");
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:(self.titleColor == nil ? color : self.titleColor)
                       range:NSMakeRange(0, model.lableTitle.length)];
    if (![QZZVerificationTools isEmptyString:model.info]) {
        [attrString addAttribute:NSForegroundColorAttributeName
                           value:(self.contentTextColor == nil ? color : self.contentTextColor)
                           range:NSMakeRange(model.lableTitle.length+1, model.info.length)];
    }
}
@end
