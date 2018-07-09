//
//  HomeOptionsBtnCell.m
//  
//
//  Created by qinzhongzeng on 2017/1/10.
//  Copyright © 2017年 bejingyimeng. All rights reserved.
//

#import "HomeOptionsBtnCell.h"

@interface HomeOptionsBtnCell()

@property (weak, nonatomic) IBOutlet UIImageView *OptionImageView;
@property (weak, nonatomic) IBOutlet UILabel *OptionTextLabel;

@end

@implementation HomeOptionsBtnCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)gotoShowView:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectedThisOption:)]) {
        [self.delegate selectedThisOption:self.key];
    }
}

- (void)setModel:(OptionButtonModel *)model{

    _model = model;
    self.OptionImageView.image = [UIImage imageNamed:model.optionBtnImageName];
    self.OptionTextLabel.text = model.optionBtnLabel;
}
@end
