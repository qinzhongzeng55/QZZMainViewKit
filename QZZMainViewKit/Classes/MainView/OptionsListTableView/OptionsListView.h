//
//  OptionsListView.h
//  
//  带标题的下拉框
//  Created by 秦忠增 on 2018/4/19.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionsListTableViewCell.h"
#import "QZZMainViewKit.h"

///选项选中后执行的block
typedef void (^OptionSelectedBlock)(OptionButtonModel *model,NSIndexPath *key);

@interface OptionsListView : UIView

///选项数组
@property (nonatomic, strong) NSMutableArray *dataArray;
///标题
@property (nonatomic, copy) NSString *optionsListTitle;
///选项选中后执行的block
@property (nonatomic, copy) OptionSelectedBlock OptionSelectedBlock;
@property (nonatomic, strong) NSIndexPath *key;

///设置头部lineView的背景颜色
- (void)settingBackgroundColorOfTopView:(UIColor *)color;
///设置lineView的颜色
- (void)settingLineViewColor:(UIColor *)color;
///隐藏 >
- (void)hiddenMoreImageView:(BOOL)isHidden;
///设置>图片
- (void)settingMoreImageView:(UIImage *)image;
///设置选项的字体
- (void)settingContentTextColor:(UIColor *)color font:(UIFont *)font;
///设置弹框的字体
- (void)settingTitleColor:(UIColor *)color font:(UIFont *)font;
///设置头部图片
- (void)settingTopImageView:(UIImage *)image;
///设置头部view的高度
- (void)settingTopViewHeight:(CGFloat)height;
///设置containView的圆角角度
- (void)settingContainViewRadius:(CGFloat)radius;
///设置containViewd的宽度
- (void)settingContainViewWidth:(CGFloat)Width;
@end
