//
//  OtherChatTableViewCell.m
//  KeepYoungManager
//
//  Created by 秦忠增 on 2018/7/10.
//  Copyright © 2018年 wanqianyanglao. All rights reserved.
//

#import "OtherChatTableViewCell.h"
#import <float.h>

@interface OtherChatTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *TextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@end

@implementation OtherChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImageView.layer.cornerRadius = 30;
    self.iconImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - setter,getter
- (void)setModel:(ChatInfoModel *)model{
    _model = model;
    self.TextLabel.text = model.chatContent;
    [UILabel changeSpace:self.TextLabel withLineSpace:kWebLineSpacing WordSpace:kWebWordsSpacing];
    [self buJuTextView];
}
#pragma mark - 布局子控件
- (void)buJuTextView{
    
    UIFont *contentFont = self.TextLabel.font;
    CGSize contentTextViewMaxSize = CGSizeMake(Screen_Width-130, Screen_Height);
    CGSize size = [[AutomaticSizeTools sharedAutomaticSizeTools] boundingALLRectWithSize:self.TextLabel.text Font:contentFont MaxSize:contentTextViewMaxSize LineSpacing:kWebLineSpacing WordsSpacing:kWebWordsSpacing];
    UIFontDescriptor *ctfFont = contentFont.fontDescriptor;
    NSNumber *fontString = [ctfFont objectForKey:@"NSFontSizeAttribute"];
    if (size.height <= ([fontString integerValue]+kWebLineSpacing+8)) {
        size = CGSizeMake(size.width, size.height - kWebLineSpacing);
        [UILabel changeSpace:self.TextLabel withLineSpace:0 WordSpace:kWebWordsSpacing];
    }else{
        [UILabel changeSpace:self.TextLabel withLineSpace:kWebLineSpacing WordSpace:kWebWordsSpacing];
    }
    __weak typeof(self) weakSelf = self;
    [self.TextLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(weakSelf.iconImageView.mas_trailing).offset(26);
        make.top.equalTo(weakSelf.iconImageView.mas_top).offset(18);
        make.size.equalTo(@(size));
    }];
    [self.bgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.TextLabel).offset(-20);
        make.trailing.equalTo(weakSelf.TextLabel).offset(10);
        make.top.equalTo(weakSelf.TextLabel).offset(-8);
        CGFloat H = size.height+16;
        make.height.equalTo(@(H));
        make.bottom.equalTo(weakSelf.TextLabel).offset(8);
        if (H > 49.f) {
            make.bottom.equalTo(weakSelf.contentView).offset(-8);
        }
    }];
    [self settingContainView:size];
    [self.contentView layoutIfNeeded];
}
- (void)settingContainView:(CGSize)size{

    __weak typeof(self) weakSelf = self;
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat H = size.height+16;
        if (H <= 49.f) {
            make.bottom.equalTo(weakSelf.iconImageView).offset(8);
        }
        make.top.leading.trailing.bottom.equalTo(self);
    }];
}

#pragma mark - 设置头像
- (void)settingIconImage:(UIImage *)image{
    self.iconImageView.image = image;
}
#pragma mark - 设置聊天内容背景图片
- (void)settingChatContentBGImage:(UIImage *)image{
    self.bgImageView.image = image;
}
#pragma mark - 设置聊天内容字体
- (void)settingChatContentFont:(UIFont *)font{
    self.TextLabel.font = font;
}
#pragma mark - 设置聊天内容字体颜色
- (void)settingChatContentTextColor:(UIColor *)color{
    self.TextLabel.textColor = color;
}
@end
