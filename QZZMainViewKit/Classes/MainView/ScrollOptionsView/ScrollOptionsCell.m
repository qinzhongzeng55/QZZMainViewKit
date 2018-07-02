//
//  ScrollOptionsCell.m
//  WQYL_SYS
//
//  Created by 秦忠增 on 2018/4/23.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import "ScrollOptionsCell.h"

@interface ScrollOptionsCell ()

@property (weak, nonatomic) IBOutlet UIButton *optionBtn;
@end

@implementation ScrollOptionsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark - 选择这个选项
- (IBAction)selectedThisOption:(UIButton *)sender {
    
    self.optionBtn.selected = YES;
    if ([self.delegate respondsToSelector:@selector(selectedThisOption:)]) {
        [self.delegate selectedThisOption:self.key];
    }
}
#pragma mark - 设置这个选项是否被选中
- (void)settingSelectedForOptionBtn:(BOOL)isSelected{
    self.optionBtn.selected = isSelected;
}
#pragma mark - 设置选项标题
- (void)settingTitleLabelText:(NSString *)text{
    [self.optionBtn setTitle:text forState:UIControlStateNormal];
}
@end
