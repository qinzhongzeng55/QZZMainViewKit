//
//  SelectedTableViewCell.h
//  
//
//  Created by qinzhongzeng on 16/7/29.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QZZPublicModel/TableViewCellModel.h>
#import <QZZCategoryKit/UIImage+Extension.h>

@protocol SelectedTableViewCellDelegate <NSObject>

@optional
- (void)selectedBtnDidClick:(TableViewCellModel *)model key:(NSIndexPath *)key;

@end

@interface SelectedTableViewCell : UITableViewCell

@property (nonatomic, assign) id<SelectedTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *key;
@property (nonatomic, strong) TableViewCellModel *model;
@property (nonatomic, assign) BOOL isDetail;

///隐藏lineView
- (void)hiddenLineView:(BOOL)isHidden;
///设置lineView的背景颜色
- (void)settingLineViewColor:(UIColor *)color;
///设置>图片
- (void)settingMoreImageView:(UIImage *)image;
///隐藏 >
- (void)hiddenMoreImageView:(BOOL)isHidden;
///设置标题的SIZE
- (void)settingTitleSize:(CGSize)size;
///设置标题左侧的距离
- (void)settingTitleLeft:(CGFloat)left;
///设置标题的字体
- (void)settingTitleColor:(UIColor *)color font:(UIFont *)font;
///设置内容的字体
- (void)settingContentTextColor:(UIColor *)color font:(UIFont *)font;
///隐藏选择按钮
- (void)hiddenSelectedBtn:(BOOL)isHidden;
@end
