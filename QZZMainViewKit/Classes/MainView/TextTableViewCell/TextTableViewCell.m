//
//  TextTableViewCell.m
//  
//
//  Created by qinzhongzeng on 16/7/29.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import "TextTableViewCell.h"

@interface TextTableViewCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentText;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineLConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleWConstraint;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
@implementation TextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentText.delegate = self;
    [self.contentText addTarget:self action:@selector(getModelinfo:) forControlEvents:UIControlEventEditingDidEnd];
    [self.contentText addTarget:self action:@selector(resignResponder) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.contentText addTarget:self action:@selector(beginEditingContent) forControlEvents:UIControlEventEditingDidBegin];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField endEditing:YES];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    return YES;
}

- (void)beginEditingContent{
    
    
}

-(void)getModelinfo:(UITextField *)textField
{
    self.model.info = self.contentText.text;
    if([self.delegate respondsToSelector:@selector(endEdittingWithModel:key:)]){
        
        [self.delegate endEdittingWithModel:self.model key:self.key];
    }
}

- (void)resignResponder{
    
    [self.contentText resignFirstResponder];
}
#pragma mark - method
- (void)settingContentTextColor:(UIColor *)color{
    
    self.contentText.textColor = color;
}

- (void)settingKeyboardType:(UIKeyboardType)KeyboardType{
    
    //数字键盘UIKeyboardTypeNumberPad
    self.contentText.keyboardType = KeyboardType;
}

- (void)settingLineLConstraint:(CGFloat)width{
    
    self.lineLConstraint.constant = width;
}

- (void)settingTitleLConstraint:(CGFloat)width{
    
    self.titleLConstraint.constant = width;
}
- (void)settingTitleWidth:(CGFloat)width{
    
    self.titleWConstraint.constant = width;
}
///隐藏lineView
- (void)hiddenLineView:(BOOL)isHidden{
    self.lineView.hidden = isHidden;
}
#pragma mark - setter,getter
- (void)setModel:(TableViewCellModel *)model{
    
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"%@: ",model.lableTitle];
    if (model.info == nil || [model.info isEqualToString:@""]) {
        if (model.placeHoled == nil || [model.placeHoled isEqualToString:@""]) {
//            self.contentText.placeholder = @"请填写";
        }else{
            self.contentText.placeholder = model.placeHoled;
        }
    }else{
        self.contentText.text = model.info;
    }
}
- (void)setIsDetail:(BOOL)isDetail{
    
    _isDetail = isDetail;
    self.contentText.enabled = !isDetail;
    
}
- (void)setColor:(UIColor *)color{
    
    self.titleLabel.textColor = color;
}
@end
