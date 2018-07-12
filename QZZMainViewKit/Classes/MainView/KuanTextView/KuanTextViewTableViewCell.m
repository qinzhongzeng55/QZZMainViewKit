
//
//  KuanTextViewTableViewCell.m
//  CRMNEW
//
//  Created by qinzhongzeng on 16/7/29.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import "KuanTextViewTableViewCell.h"

@interface KuanTextViewTableViewCell ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *placeHudLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *textCurrentLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *textMaxLengthLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewHConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *placeHolderTConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelHConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTextViewBConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTextViewTConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelLConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *placeHolderLConstraint;
@property (weak, nonatomic) IBOutlet UIView *topLineView;
@end
@implementation KuanTextViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self showContentViewBorder:YES];
    self.contentTextView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TableViewCellModel *)model{
    
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.lableTitle];
    if (model.info == nil || [model.info isEqualToString:@""]) {
        self.placeHudLabel.hidden = NO;
        self.placeHudLabel.text = model.placeHoled;
        if (self.color) {
            self.contentTextView.textColor = self.color;
        }else{
            self.contentTextView.textColor = [UIColor blackColor];
        }
    }else{
        self.placeHudLabel.hidden = YES;
        self.placeHudLabel.text = model.placeHoled;
        self.contentTextView.text = model.info;
        self.contentTextView.textColor = [UIColor blackColor];
    }
}
#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSInteger lengtn = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length;
    self.textCurrentLengthLabel.text = [NSString stringWithFormat:@"%ld",(long)lengtn];
    if (lengtn > 0) {
        self.textCurrentLengthLabel.textColor = [UIColor colorWithWhite:51/255.0 alpha:1];
    }else{
        self.textCurrentLengthLabel.textColor = [UIColor colorWithWhite:199/255.0 alpha:1];
    }
    if (self.maxLengtn > 0) {
        if (lengtn >= self.maxLengtn) {//超过字数限制
            return NO;
        }
    }
    if ([text isEqualToString:@"\n"]) {
        [textView endEditing:YES];
        if ([self.delegate respondsToSelector:@selector(endEdittingWithIndexPath:withModel:)]) {
            [self.delegate endEdittingWithIndexPath:self.key withModel:self.model];
        }
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{

    if (textView.text.length > 0) {
        self.placeHudLabel.hidden = YES;
    }else{
    
        self.placeHudLabel.hidden = NO;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView{

    self.placeHudLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([self.contentTextView.text isEqualToString:@""] || self.contentTextView.text == nil) {
        self.placeHudLabel.hidden = NO;
    }
    self.model.info = self.contentTextView.text;
    self.contentTextView.textColor = [UIColor blackColor];
    [self.contentTextView resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(endEdittingWithIndexPath:withModel:)]) {
        [self.delegate endEdittingWithIndexPath:self.key withModel:self.model];
    }
}
#pragma mark - 是否显示文本框边框
- (void)showContentViewBorder:(BOOL)isShow{
    if (isShow) {
        self.contentTextView.layer.cornerRadius = 5;
        self.contentTextView.layer.masksToBounds = YES;
        self.contentTextView.layer.borderColor = [UIColor colorWithWhite:153/255.0 alpha:1].CGColor;
        self.contentTextView.layer.borderWidth = 1;
    }else{
        self.contentTextView.layer.borderWidth = 0;
    }
}

#pragma mark - method
- (void)settingTitleColor:(UIColor *)color font:(UIFont *)font{
    
    self.titleLabel.textColor = color;
    self.titleLabel.font = font;
}
///设置占位文字
- (void)settingPlaceHolderColor:(UIColor *)color  font:(UIFont *)font{
    self.placeHudLabel.textColor = color;
    self.placeHudLabel.font = font;
}
///设置字体大小
- (void)settingFontSize:(CGFloat)size{
    self.placeHudLabel.font = [UIFont systemFontOfSize:size];
    self.textCurrentLengthLabel.font = [UIFont systemFontOfSize:size];
    self.textMaxLengthLabel.font = [UIFont systemFontOfSize:size];
    self.contentTextView.font = [UIFont systemFontOfSize:size];
}


///隐藏字数label
- (void)hiddenTextLengthLabel:(BOOL)isHidden{
    self.textCurrentLengthLabel.hidden = isHidden;
    self.textMaxLengthLabel.hidden = isHidden;
}
///设置lineView的背景颜色
- (void)settingLineViewColor:(UIColor *)color{
    self.topLineView.backgroundColor = color;
}
///设置lineView高度
- (void)settinglineViewHeigth:(CGFloat)height{
    self.lineViewHConstraint.constant = height;
}
///隐藏lineView
- (void)hiddenLineView{
    self.lineViewHConstraint.constant = 0;
    [self.contentView layoutIfNeeded];
}
///隐藏titleLabel
- (void)hiddenTitleLabel{
    self.titleLabel.hidden = YES;
    self.titleLabelHConstraint.constant = 0;
    self.contentTextViewBConstraint.constant = 0;
    [self.contentView layoutIfNeeded];
}
//设置文本框下边距
- (void)settingContentTextViewBConstraint:(CGFloat)constraint{
    self.contentTextViewBConstraint.constant = constraint;
    [self.contentView layoutIfNeeded];
}
///设置文本框上边距
- (void)settingContentTextViewTConstraint:(CGFloat)constraint{
    self.contentTextViewTConstraint.constant = constraint;
    [self.contentView layoutIfNeeded];
}
//设置占位文字上边距
- (void)settingPlaceHolderTConstraint:(CGFloat)constraint{
    self.placeHolderTConstraint.constant = constraint;
    [self.contentView layoutIfNeeded];
}
///设置占位文字左边距
- (void)settingPlaceHolderLConstraint:(CGFloat)constraint{
    self.placeHolderLConstraint.constant = constraint;
    [self.contentView layoutIfNeeded];
}
//设置标题上边距
- (void)settingTitleLabelTConstraint:(CGFloat)constraint{
    self.titleLabelTConstraint.constant = constraint;
    [self.contentView layoutIfNeeded];
}
///设置标题左边距
- (void)settingTitleLabelLConstraint:(CGFloat)constraint{
    self.titleLabelLConstraint.constant = constraint;
    [self.contentView layoutIfNeeded];
}
#pragma mark - setter,getter
- (void)setIsEditting:(BOOL)isEditting{
    
    _isEditting = isEditting;
    self.contentTextView.editable = isEditting;
}
- (void)setMaxLengtn:(NSInteger)maxLengtn{
    _maxLengtn = maxLengtn;
    self.textMaxLengthLabel.text = [NSString stringWithFormat:@"/%ld",(long)maxLengtn];
}
@end
