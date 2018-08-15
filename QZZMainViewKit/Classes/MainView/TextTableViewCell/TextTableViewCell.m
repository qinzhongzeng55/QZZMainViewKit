//
//  TextTableViewCell.m
//
//
//  Created by qinzhongzeng on 16/7/29.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import "TextTableViewCell.h"

@interface TextTableViewCell ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentText;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineLConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleWConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHContraint;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
@implementation TextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentText.delegate = self;
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
    if ([fontString integerValue] > 22) {
        self.contentText.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        self.contentText.contentInset = UIEdgeInsetsMake(margin, 0, -margin, 0);
    }
}
#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text{
    if (self.maxCount > 0) {
        if (textView.text.length >= self.maxCount && ![text isEqualToString:@""]) {
            [self endEditing:YES];
            return YES;
        }
    }
    if(textView.text.length > 0){
        self.contentText.textColor = self.contentTextColor;
        self.contentText.font = self.contentTextFont;
    }else{
        self.contentText.textColor = self.placehodlerColor;
        self.contentText.font = self.placehodlerFont;
    }
    if ([text isEqualToString:@"\n"]) {
        [self endEditing:YES];
        self.contentText.text = [textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([QZZVerificationTools isEmptyString:self.model.info]) {
        self.contentText.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    self.model.info = self.contentText.text;
    [self.contentText resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(endEdittingWithModel:key:)]) {
        [self.delegate endEdittingWithModel:self.model key:self.key];
    }
}
#pragma mark - method
- (void)resignResponder{
    [self.contentText resignFirstResponder];
}
#pragma mark - 设置键盘类型
- (void)settingKeyboardType:(UIKeyboardType)KeyboardType{
    
    //数字键盘UIKeyboardTypeNumberPad
    self.contentText.keyboardType = KeyboardType;
}
#pragma mark - 设置lineView左边距
- (void)settingLineLConstraint:(CGFloat)width{
    
    self.lineLConstraint.constant = width;
    [self layoutIfNeeded];
}
#pragma mark - 设置标题左边距
- (void)settingTitleLConstraint:(CGFloat)left{
    
    self.titleLConstraint.constant = left;
    [self layoutIfNeeded];
}
#pragma mark - 设置标题的SIZE
- (void)settingTitleSize:(CGSize)size{
    self.titleWConstraint.constant = size.width;
    self.titleHContraint.constant = size.height;
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
#pragma mark - 设置标题的字体
- (void)settingTitleColor:(UIColor *)color font:(UIFont *)font{
    self.titleLabel.textColor = color;
    self.titleLabel.font = font;
}
#pragma mark - setter,getter
- (void)setModel:(TableViewCellModel *)model{
    
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"%@: ",model.lableTitle];
    if ([QZZVerificationTools isEmptyString:model.info]) {
        if ([QZZVerificationTools isEmptyString:model.placeHoled]) {
            //self.contentText.placeholder = @"请填写";
        }else{
            self.contentText.text = model.placeHoled;
        }
        self.contentText.textColor = self.placehodlerColor ? self.placehodlerColor : [UIColor colorWithWhite:200/255.0 alpha:1];
        self.contentText.font = self.placehodlerFont;
    }else{
        self.contentText.text = model.info;
        self.contentText.textColor = self.contentTextColor ? self.contentTextColor :[UIColor colorWithWhite:102/255.0 alpha:1];
        self.contentText.font = self.contentTextFont;
    }
}
@end
