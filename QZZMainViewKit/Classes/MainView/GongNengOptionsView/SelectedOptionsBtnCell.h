//
//  SelectedOptionsBtnCell.h
//  
//
//  Created by qinzhongzeng on 2017/1/10.
//  Copyright © 2017年 bejingyimeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QZZPublicModel/OptionButtonModel.h>

@protocol SelectedOptionsBtnCellDelegate <NSObject>

@optional
- (void)selectedThisOption:(NSIndexPath *)key;

@end

@interface SelectedOptionsBtnCell : UICollectionViewCell

@property (nonatomic, strong) NSIndexPath *key;
@property (nonatomic, strong) OptionButtonModel *model;
@property (nonatomic, assign) id<SelectedOptionsBtnCellDelegate> delegate;

///设置图片的宽度(长度 1:1)
- (void)settingImageViewWidth:(CGFloat)width;
///设置功能按钮的font
- (void)settingLabelFont:(UIFont *)font;
///设置功能按钮的字体颜色
- (void)settingTextColor:(UIColor *)color;
///设置文本头部距离
- (void)settingTitleLabelTop:(CGFloat)top;
///设置文本底部距离
- (void)settingTitleLabelBottom:(CGFloat)bottom;
///设置文本高度
- (void)settingTitlelabelHeight:(CGFloat)height;
@end
