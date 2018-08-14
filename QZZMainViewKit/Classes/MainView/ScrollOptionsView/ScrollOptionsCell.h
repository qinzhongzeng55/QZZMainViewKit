//
//  ScrollOptionsCell.h
//  WQYL_SYS
//
//  Created by 秦忠增 on 2018/4/23.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollOptionsCellDelegate <NSObject>

@optional
///选择这个选项
- (void)selectedThisOption:(NSIndexPath *)key;

@end

@interface ScrollOptionsCell : UICollectionViewCell

@property (nonatomic, strong) NSIndexPath *key;
@property (nonatomic, assign) id<ScrollOptionsCellDelegate> delegate;

///设置选项标题
- (void)settingTitleLabelText:(NSString *)text;
///设置这个选项是否被选中
- (void)settingSelectedForOptionBtn:(BOOL)isSelected;
///设置选项字体
- (void)settingOptionTitleColor:(UIColor *)color selectedColor:(UIColor *)selectedColor font:(UIFont *)font;
@end
