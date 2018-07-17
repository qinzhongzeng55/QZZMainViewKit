//
//  MoreSelectedSearchOptionsListView.h
//  
//  多选下拉框
//  Created by 秦忠增 on 2018/5/8.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreSelectedOptionsListCell.h"
#import "QZZMainViewKit.h"

///选项选中后执行的block
typedef void (^OptionMoreSelectedBlock)(NSMutableArray *selectedArray,NSIndexPath *key);

@interface MoreSelectedSearchOptionsListView : UIView

///选项数组
@property (nonatomic, strong) NSMutableArray *dataArray;
///搜索占位标题
@property (nonatomic, copy) NSString *searchPlaceholder;
///选项选中后执行的block
@property (nonatomic, copy) OptionMoreSelectedBlock OptionSelectedBlock;
///是否搜索
@property (nonatomic, assign) BOOL isSearch;
///搜索结果数据
@property (nonatomic, strong) NSMutableArray *searchResultArray;
@property (nonatomic, strong) NSIndexPath *key;

///设置头部View的背景颜色
- (void)settingBackgroundColorOfTopView:(UIColor *)color;
///设置确定按钮的背景颜色
- (void)settingBackgroundColorOfQueDingBtn:(UIColor *)color;
///设置选中按钮的图片
- (void)settingImage:(UIImage *)img withSelectedImage:(UIImage *)selectedImg;
///设置选项lineView的颜色
- (void)settingLineViewColor:(UIColor *)color;
///设置选项选中按钮左侧的距离
- (void)settingSelectedBtnLeft:(CGFloat)left;
///设置选项选中按钮的大小
- (void)settingSelectedBtnWidth:(CGFloat)width;
///设置选项的字体
- (void)settingContentTextColor:(UIColor *)color font:(UIFont *)font;

///设置提示信息
- (void)settingTiShi:(NSString *)tiShi;
@end
