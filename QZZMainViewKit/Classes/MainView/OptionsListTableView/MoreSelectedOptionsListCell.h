//
//  MoreSelectedOptionsListCell.h
//  
//  多选下拉框cell
//  Created by 秦忠增 on 2018/5/8.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QZZPublicModel/OptionButtonModel.h>

@protocol MoreSelectedOptionsListCellDelegate <NSObject>

@optional
//选中该选项
- (void)selectedThisOption:(NSIndexPath *)key;

@end

@interface MoreSelectedOptionsListCell : UITableViewCell

@property (nonatomic, assign) id<MoreSelectedOptionsListCellDelegate> delegate;
@property (nonatomic, strong) OptionButtonModel *model;
@property (nonatomic, strong) NSIndexPath *key;
///是否被选中
@property (nonatomic, assign) BOOL isSelected;

///隐藏底部lineView
- (void)hiddenLineView:(BOOL)isHidden;
//设置lineView的颜色
- (void)settingLineViewColor:(UIColor *)color;
///设置选中按钮的图片
- (void)settingImage:(UIImage *)img withSelectedImage:(UIImage *)selectedImg;
///设置选中按钮左侧的距离
- (void)settingSelectedBtnLeft:(CGFloat)left;
///设置选中按钮的大小
- (void)settingSelectedBtnWidth:(CGFloat)width;
///设置选项的字体
- (void)settingContentTextColor:(UIColor *)color font:(UIFont *)font;
@end
