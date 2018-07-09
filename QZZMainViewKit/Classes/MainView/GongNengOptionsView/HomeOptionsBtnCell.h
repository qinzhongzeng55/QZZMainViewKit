//
//  HomeOptionsBtnCell.h
//  
//
//  Created by qinzhongzeng on 2017/1/10.
//  Copyright © 2017年 bejingyimeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QZZPublicModel/OptionButtonModel.h>

@protocol HomeOptionsBtnCellDelegate <NSObject>

@optional
- (void)selectedThisOption:(NSIndexPath *)key;

@end

@interface HomeOptionsBtnCell : UICollectionViewCell

@property (nonatomic, strong) NSIndexPath *key;
@property (nonatomic, strong) OptionButtonModel *model;
@property (nonatomic, assign) id<HomeOptionsBtnCellDelegate> delegate;

///设置图片的宽度(长度 1:1)
- (void)settingImageViewWidth:(CGFloat)width;
///设置功能按钮的font
- (void)settingLabelFont:(UIFont *)font;
@end
