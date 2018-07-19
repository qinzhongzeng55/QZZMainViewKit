//
//  KuanTextViewAllDataCell.m
//  Pods
//
//  Created by 秦忠增 on 2018/7/17.
//

#import "KuanTextViewAllDataCell.h"

@interface KuanTextViewAllDataCell ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *topLineView;
@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewHConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelHConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelLConstraint;


@property (nonatomic, assign) CGFloat contentLabelLeft;
@property (nonatomic, assign) CGFloat contentLabelTop;
@property (nonatomic, assign) CGFloat contentLabelRight;
@property (nonatomic, assign) CGFloat contentLabelBottom;

@property (nonatomic, assign) CGFloat contentContainViewLeft;
@property (nonatomic, assign) CGFloat contentContainViewTop;
@property (nonatomic, assign) CGFloat contentContainViewRight;
@property (nonatomic, assign) CGFloat contentContainViewBottom;

@end

@implementation KuanTextViewAllDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
///设置标题字体及字体颜色
- (void)settingTitleColor:(UIColor *)color font:(UIFont *)font{
    
    self.titleLabel.textColor = color;
    self.titleLabel.font = font;
}
///设置内容文字
- (void)settingContentTextColor:(UIColor *)color font:(UIFont *)font{
    
    self.contentLabel.textColor = color;
    self.contentLabel.font = font;
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
    self.contentLabelTop = top;
    self.contentLabelLeft = left;
    self.contentLabelBottom = bottom;
    self.contentLabelRight = right;
}
///设置文本框外边距
- (void)settingContainViewConstantForTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right{
    self.contentContainViewTop = top;
    self.contentContainViewLeft = left;
    self.contentContainViewBottom = bottom;
    self.contentContainViewRight = right;
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
    
    UIFont *contentFont = self.contentLabel.font;
    CGSize pingLunLabelMaxSize = CGSizeMake(Screen_Width-self.contentLabelLeft*2, Screen_Height);
    CGSize size = [self boundingALLRectWithSize:self.contentLabel.text Font:contentFont Size:pingLunLabelMaxSize];
    __weak typeof(self) weakSelf = self;
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(weakSelf.contentView).offset(-weakSelf.contentLabelRight);
        make.leading.equalTo(weakSelf.contentView).offset(weakSelf.contentLabelLeft);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(weakSelf.contentLabelTop);
        
        make.bottom.equalTo(weakSelf.titleLabel.mas_bottom).offset(weakSelf.contentLabelTop+size.height);
    }];
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView).offset(weakSelf.contentContainViewLeft);
            make.trailing.equalTo(weakSelf.contentView).offset(-weakSelf.contentContainViewRight);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(weakSelf.contentContainViewTop);
        CGFloat H = size.height+16;
        make.bottom.equalTo(weakSelf.titleLabel.mas_bottom).offset(weakSelf.contentLabelTop+H);
    }];
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
- (void)setModel:(TableViewCellModel *)model{
    
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.lableTitle];
    if (model.info == nil || [model.info isEqualToString:@""] || [model.info isEqualToString:@"(null)"]) {
        
    }else{
        self.contentLabel.text = model.info;
        self.contentLabel.textColor = [UIColor blackColor];
    }
    [self buJuTextView];
}
@end
