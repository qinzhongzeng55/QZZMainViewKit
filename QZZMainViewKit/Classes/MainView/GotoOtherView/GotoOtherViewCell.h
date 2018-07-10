//
//  GotoOtherViewCell.h
//  
//  跳转到别的页面样式的cell
//  Created by 秦忠增 on 2018/4/20.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QZZCategoryKit/UIImage+Extension.h>

@protocol GotoOtherViewCellDelegate <NSObject>

@optional
///跳转到别的页面
- (void)gotoOtherView:(NSIndexPath *)key;

@end

@interface GotoOtherViewCell : UITableViewCell

@property (nonatomic, assign) id<GotoOtherViewCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *key;

///隐藏底部的line
- (void)hiddenLineView:(BOOL)isHidden;
///设置lineView的背景颜色
- (void)settingLineViewColor:(UIColor *)color;
///设置选项文本
- (void)settingTitleView:(NSString *)title font:(UIFont *)font;
///设置图片大小
- (void)settingImageWidth:(CGFloat)width;
///设置图片左侧距离
- (void)settingImageLeft:(CGFloat)left;
///设置文本左侧距离
- (void)settingTitleLeft:(CGFloat)left;
///是否显示图片
- (void)showImageView:(BOOL)isShow;
///设置图片
- (void)settingImageView:(UIImage *)image;
   
@end
