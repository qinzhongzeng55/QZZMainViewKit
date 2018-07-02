//
//  SelectedOptionsBtnCell.h
//  
//  上面是图片下面是标题的CollectionViewCell
//  Created by qinzhongzeng on 2017/1/10.
//  Copyright © 2017年 bejingyimeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QZZPublicModel/OptionButtonModel.h>

@protocol SelectedOptionsBtnCellDelegate <NSObject>

@optional
- (void)selectedThisOption:(NSIndexPath *)key;

@end

@interface SelectedOptionsBtnCell : UICollectionViewCell

@property (nonatomic, strong) NSIndexPath *key;
@property (nonatomic, strong) OptionButtonModel *model;
@property (nonatomic, assign) id<SelectedOptionsBtnCellDelegate> delegate;
///设置标题颜色
- (void)settingTitleColor:(UIColor *)color;
///设置标题字体
- (void)settingTitleFont:(UIFont *)font;
@end
