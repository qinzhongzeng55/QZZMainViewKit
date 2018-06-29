//
//  NavSearchBarView.h
//  
//  导航栏上的搜索框
//  Created by 秦忠增 on 2018/4/28.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QZZMainViewKit.h"

@protocol NavSearchBarViewDelegate <NSObject>

@optional
///更新数据
- (void)loadDataList;

@end

@interface NavSearchBarView : UIView

@property (nonatomic, assign) id<NavSearchBarViewDelegate> delegate;
///所属的关键字
@property (nonatomic, copy) NSString *searchString;
///设置占位文字
- (void)settingPlaceHolder:(NSString *)placeHolder;
//设置搜索框背景
- (void)settingBackgroundImage:(UIImage *)image;
///更新数据
- (void)loadDataList;
///结束编辑
- (void)endEditing;
///设置搜索框左右两侧的间距
- (void)settingSearchBarLRConstratint:(CGFloat)constraint;
@end
