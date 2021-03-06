
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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *placeHolderLConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelHConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelLConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTextViewBConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTextViewTConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTextViewLConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTextViewRConstraint;
@property (weak, nonatomic) IBOutlet UIView *lineView;
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
#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        
        if (offsetRange.location < self.maxLengtn) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = self.maxLengtn - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = @"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }
            else
            {
                __block NSInteger idx = 0;
                __block NSString  *trimString = @"";//截取出的字串
                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                          
                                          if (idx >= rg.length) {
                                              *stop = YES; //取出所需要就break，提高效率
                                              return ;
                                          }
                                          
                                          trimString = [trimString stringByAppendingString:substring];
                                          
                                          idx++;
                                      }];
                
                s = trimString;
            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            //既然是超出部分截取了，哪一定是最大限制了。
            self.textCurrentLengthLabel.text = [NSString stringWithFormat:@"%ld",(long)self.maxLengtn];
        }
        return NO;
    }
    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    if (textView.text.length > 0) {
        self.placeHudLabel.hidden = YES;
    }else{
        
        self.placeHudLabel.hidden = NO;
    }
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    if (existTextNum > self.maxLengtn)
    {
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:self.maxLengtn];
        
        [textView setText:s];
    }
    self.textCurrentLengthLabel.text = [NSString stringWithFormat:@"%ld",existTextNum];
    //不让显示负数 口口日(显示剩余字数)
//    self.textCurrentLengthLabel.text = [NSString stringWithFormat:@"%ld",MAX(0,self.maxLengtn - existTextNum)];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {

    self.placeHudLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
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
///设置标题字体及字体颜色
- (void)settingTitleColor:(UIColor *)color font:(UIFont *)font;{
    
    self.titleLabel.textColor = color;
    self.titleLabel.font = font;
}
///设置占位文字
- (void)settingPlaceHolderColor:(UIColor *)color font:(UIFont *)font{
    self.placeHudLabel.textColor = color;
    self.placeHudLabel.font = font;
}
///设置当前字数文本
- (void)settingCurrentNumLabelColor:(UIColor *)color font:(UIFont *)font{
    self.textCurrentLengthLabel.textColor = color;
    self.textCurrentLengthLabel.font = font;
}
///设置最大字数文本
- (void)settingMaxNumLabelColor:(UIColor *)color font:(UIFont *)font{
    self.textMaxLengthLabel.textColor = color;
    self.textMaxLengthLabel.font = font;
}
///设置内容文字
- (void)settingContentTextColor:(UIColor *)color font:(UIFont *)font{
    
    self.contentTextView.textColor = color;
    self.contentTextView.font = font;
}
///隐藏字数label
- (void)hiddenTextLengthLabel:(BOOL)isHidden{
    self.textCurrentLengthLabel.hidden = isHidden;
    self.textMaxLengthLabel.hidden = isHidden;
}

///隐藏顶部的lineView
- (void)hiddenLineView{
    self.lineViewHConstraint.constant = 0;
    [self.contentView layoutIfNeeded];
}
///隐藏底部的lineView
- (void)hiddenBottomLineView:(BOOL)isHidden{
    self.lineView.hidden = isHidden;
}
///隐藏titleLabel
- (void)hiddenTitleLabel{
    self.titleLabel.hidden = YES;
    self.titleLabelHConstraint.constant = 0;
    self.contentTextViewBConstraint.constant = 0;
    [self.contentView layoutIfNeeded];
}
///设置文本框边距
- (void)settingContentTextViewConstantForTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right{
    self.contentTextViewTConstraint.constant = top;
    self.contentTextViewLConstraint.constant = left;
    self.contentTextViewBConstraint.constant = bottom;
    self.contentTextViewRConstraint.constant = right;
    [self.contentView layoutIfNeeded];
}
//设置占位文字边距
- (void)settingPlaceHolderConstantForTop:(CGFloat)top left:(CGFloat)left{
    self.placeHolderTConstraint.constant = top;
    self.placeHolderLConstraint.constant = left;
    [self.contentView layoutIfNeeded];
}
//设置标题边距
- (void)settingTitleLabelConstantForTop:(CGFloat)top left:(CGFloat)left height:(CGFloat)height{
    self.titleLabelTConstraint.constant = top;
    self.titleLabelLConstraint.constant = left;
    self.contentTextViewLConstraint.constant = left;
    self.titleLabelHConstraint.constant = height;
    [self.contentView layoutIfNeeded];
}
#pragma mark - setter,getter
- (void)setIsEditting:(BOOL)isEditting{
    _isEditting = isEditting;
    self.contentTextView.editable = isEditting;
    self.userInteractionEnabled = isEditting;
}
- (void)setMaxLengtn:(NSInteger)maxLengtn{
    _maxLengtn = maxLengtn;
    self.textMaxLengthLabel.text = [NSString stringWithFormat:@"/%ld",(long)maxLengtn];
}
- (void)setModel:(TableViewCellModel *)model{
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.lableTitle];
    if ([QZZVerificationTools isEmptyString:model.info]) {
        self.placeHudLabel.hidden = NO;
        self.placeHudLabel.text = model.placeholder;
    }else{
        self.placeHudLabel.hidden = YES;
        self.placeHudLabel.text = model.placeholder;
        self.contentTextView.text = model.info;
        self.contentTextView.textColor = [UIColor blackColor];
    }
}
@end
