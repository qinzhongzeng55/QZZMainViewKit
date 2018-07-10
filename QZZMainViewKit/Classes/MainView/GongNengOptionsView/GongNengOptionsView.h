//
//  GongNengOptionsView.h
//  
//
//  Created by qinzhongzeng on 2016/10/26.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GongNengOptionsViewDelegate <NSObject>

@optional
- (void)optionBtnSelected:(NSIndexPath *)key;
@end

@interface GongNengOptionsView : UICollectionView

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) id<GongNengOptionsViewDelegate> selectedDelegate;

///设置功能按钮的图片的宽度(长度 1:1)
- (void)settingImageViewWidthOfOptionsBtn:(CGFloat)width;
///设置功能按钮的font
- (void)settingLabelFontOfOptionsBtn:(UIFont *)font;
///设置文本头部距离
- (void)settingTitleLabelTopOfOptionsBtn:(CGFloat)top;
///设置文本高度
- (void)settingTitlelabelHeight:(CGFloat)height;
@end
