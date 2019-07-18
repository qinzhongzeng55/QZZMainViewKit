//
//  NavSearchBarView.h
//  
//  导航栏上的搜索框
//  Created by 秦忠增 on 2018/4/28.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QZZCategoryKit/UIImage+Extension.h>

@protocol NavSearchBarViewDelegate <NSObject>

@optional
///更新数据
- (void)loadDataList;

@end

@interface NavSearchBarView : UIView

@property (nonatomic, assign) id<NavSearchBarViewDelegate> delegate;
///搜索的关键字
@property (nonatomic, copy) NSString *searchString;

///风格颜色，可用于修改输入框的光标颜色，取消按钮和选择栏被选中时候都会变成设置的颜色
- (void)settingTintColor:(UIColor *)color;
///设置搜索框中文本框的文本偏移量
- (void)settingSearchTextPositionAdjustment:(UIOffset)offset;
///设置占位文字
- (void)settingPlaceHolder:(NSString *)placeHolder;
//设置搜索框背景
- (void)settingBackgroundImage:(UIImage *)image;
///更新数据
- (void)loadDataList;
///开始编辑
- (void)beginEditing;
///结束编辑
- (void)endEditing;
///设置搜索框左右两侧的间距
- (void)settingSearchBarLRConstratint:(CGFloat)constraint;
///设置字体大小
- (void)settingTextSize:(CGFloat)textSize;
@end
