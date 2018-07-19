//
//  KuanTextViewAllDataCell.m
//  Pods
//
//  Created by 秦忠增 on 2018/7/17.
//

#import "KuanTextViewAllDataCell.h"

@interface KuanTextViewAllDataCell ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *topLineView;
@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UILabel *placeHudLabel;
@property (weak, nonatomic) IBOutlet UILabel *textCurrentLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *textMaxLengthLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *placeHolderTConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *placeHolderLConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewHConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelHConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelLConstraint;


@property (nonatomic, assign) CGFloat contentTextViewLeft;
@property (nonatomic, assign) CGFloat contentTextViewTop;
@property (nonatomic, assign) CGFloat contentTextViewRight;
@property (nonatomic, assign) CGFloat contentTextViewBottom;

@property (nonatomic, assign) CGFloat contentContainViewLeft;
@property (nonatomic, assign) CGFloat contentContainViewTop;
@property (nonatomic, assign) CGFloat contentContainViewRight;
@property (nonatomic, assign) CGFloat contentContainViewBottom;

@end

@implementation KuanTextViewAllDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
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
        }else{
            return NO;
        }
    }
    
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = self.maxLengtn - comcatstr.length;
    
    if (caninputlen >= 0){
        return YES;
    }else{
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0){
            NSString *s = @"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }else{
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

- (void)textViewDidChange:(UITextView *)textView{
    
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    if (textView.text.length > 0) {
        self.placeHudLabel.hidden = YES;
    }else{
        
        self.placeHudLabel.hidden = NO;
    }
    if (existTextNum > self.maxLengtn){
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:self.maxLengtn];
        
        [textView setText:s];
    }
    self.textCurrentLengthLabel.text = [NSString stringWithFormat:@"%ld",existTextNum];
    //不让显示负数 口口日(显示剩余字数)
    //    self.textCurrentLengthLabel.text = [NSString stringWithFormat:@"%ld",MAX(0,self.maxLengtn - existTextNum)];
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
///设置标题字体及字体颜色
- (void)settingTitleColor:(UIColor *)color font:(UIFont *)font{
    
    self.titleLabel.textColor = color;
    self.titleLabel.font = font;
}
///设置内容文字
- (void)settingContentTextColor:(UIColor *)color font:(UIFont *)font{
    
    self.contentTextView.textColor = color;
    self.contentTextView.font = font;
}
///设置占位文字
- (void)settingPlaceHolderColor:(UIColor *)color  font:(UIFont *)font{
    self.placeHudLabel.textColor = color;
    self.placeHudLabel.font = font;
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
    [self.contentView layoutIfNeeded];
}
///是否显示文本框边框
- (void)showContentViewBorder:(BOOL)isShow{
    if (isShow) {
        self.containView.layer.cornerRadius = 5;
        self.containView.layer.masksToBounds = YES;
        self.containView.layer.borderColor = [UIColor colorWithWhite:153/255.0 alpha:1].CGColor;
        self.containView.layer.borderWidth = 1;
    }else{
        self.containView.layer.borderWidth = 0;
    }
}
///设置文本框边距
- (void)settingContentTextViewConstantForTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right{
    self.contentTextViewTop = top;
    self.contentTextViewLeft = left;
    self.contentTextViewBottom = bottom;
    self.contentTextViewRight = right;
}
///设置文本框外边距
- (void)settingContainViewConstantForTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right{
    self.contentContainViewTop = top;
    self.contentContainViewLeft = left;
    self.contentContainViewBottom = bottom;
    self.contentContainViewRight = right;
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
    self.contentContainViewRight = left;
    self.titleLabelHConstraint.constant = height;
    [self.contentView layoutIfNeeded];
}
- (void)buJuTextView{
    
    UIFont *contentFont = self.contentTextView.font;
    CGSize contentTextViewMaxSize = CGSizeMake(Screen_Width-self.contentTextViewLeft*2, Screen_Height);
    CGSize size = [self boundingALLRectWithSize:self.contentTextView.text Font:contentFont Size:contentTextViewMaxSize];
    __weak typeof(self) weakSelf = self;
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(weakSelf.contentView).offset(-weakSelf.contentTextViewRight);
        make.leading.equalTo(weakSelf.contentView).offset(weakSelf.contentTextViewLeft);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(weakSelf.contentTextViewTop);
        
        make.bottom.equalTo(weakSelf.titleLabel.mas_bottom).offset(weakSelf.contentTextViewTop+size.height);
    }];
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView).offset(weakSelf.contentContainViewLeft);
            make.trailing.equalTo(weakSelf.contentView).offset(-weakSelf.contentContainViewRight);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(weakSelf.contentContainViewTop);
        CGFloat H = size.height+16;
        make.bottom.equalTo(weakSelf.titleLabel.mas_bottom).offset(weakSelf.contentTextViewTop+H);
    }];
    if (self.textMaxLengthLabel.text.length > 0) {
        
        UIFont *tiShiLabelFont = self.textMaxLengthLabel.font;
        CGSize tiShiLabelMaxSize = CGSizeMake(Screen_Width-self.contentContainViewLeft*2, Screen_Height);
        CGSize tiShiLabelSize = [self boundingALLRectWithSize:self.textMaxLengthLabel.text Font:tiShiLabelFont Size:tiShiLabelMaxSize];
        [self.textMaxLengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(weakSelf.containView).offset(-10);
            make.bottom.equalTo(weakSelf.containView).offset(-10);
            make.leading.equalTo(weakSelf.contentView).offset(Screen_Width - tiShiLabelSize.width-self.contentContainViewLeft-10);
        }];
        [self.textCurrentLengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf.textMaxLengthLabel);
            make.trailing.equalTo(weakSelf.textMaxLengthLabel.mas_leading);
        }];
    }
    [self settingContainView:size];
    [self.contentView layoutIfNeeded];
}
- (void)settingContainView:(CGSize)size{
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.bottom.equalTo(self);
    }];
}
- (CGSize)boundingALLRectWithSize:(NSString*) txt Font:(UIFont*) font Size:(CGSize) size{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:txt];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    [style setLineSpacing:0.0f];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [txt length])];
    
    CGSize realSize = CGSizeZero;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    CGRect textRect = [txt boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:style,NSKernAttributeName:@0.f} context:nil];
    realSize = textRect.size;
#else
    realSize = [txt sizeWithFont:font constrainedToSize:size];
#endif
    
    realSize.width = ceilf(realSize.width);
    realSize.height = ceilf(realSize.height);
    return realSize;
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
    [self buJuTextView];
}
- (void)setModel:(TableViewCellModel *)model{
    
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.lableTitle];
    if (model.info == nil || [model.info isEqualToString:@""] || [model.info isEqualToString:@"(null)"]) {
        self.placeHudLabel.hidden = NO;
        self.placeHudLabel.text = model.placeHoled;
    }else{
        self.placeHudLabel.hidden = YES;
        self.placeHudLabel.text = model.placeHoled;
        self.contentTextView.text = model.info;
        self.contentTextView.textColor = [UIColor blackColor];
    }
    [self buJuTextView];
}
@end
