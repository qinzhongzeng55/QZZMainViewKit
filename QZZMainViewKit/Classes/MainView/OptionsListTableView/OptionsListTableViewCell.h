//
//  OptionsListTableViewCell.h
//  
//
//  Created by 秦忠增 on 2018/4/19.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QZZPublicModel/OptionButtonModel.h>
#import <QZZCategoryKit/UIImage+Extension.h>

@protocol OptionsListTableViewCellDelegate <NSObject>

@optional
//选中该选项
- (void)selectedThisOption:(NSIndexPath *)key;

@end

@interface OptionsListTableViewCell : UITableViewCell

@property (nonatomic, assign) id<OptionsListTableViewCellDelegate> delegate;
@property (nonatomic, strong) OptionButtonModel *model;
@property (nonatomic, strong) NSIndexPath *key;

///隐藏底部line
- (void)hiddenLineView:(BOOL)isHidden;
//设置lineView的颜色
- (void)settingLineViewColor:(UIColor *)color;
///设置>图片
- (void)settingMoreImageView:(UIImage *)image;
//隐藏 > 
- (void)hiddenMoreImageView:(BOOL)isHidden;
///设置选项的字体
- (void)settingContentTextColor:(UIColor *)color font:(UIFont *)font;
@end
