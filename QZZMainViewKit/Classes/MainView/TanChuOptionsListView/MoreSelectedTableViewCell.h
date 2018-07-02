//
//  MoreSelectedTableViewCell.h
//  
//
//  Created by qinzhongzeng on 16/7/29.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QZZPublicModel/TableViewCellModel.h>
#import <QZZCategoryKit/UIImage+Extension.h>

@protocol MoreSelectedTableViewCellDelegate <NSObject>

@optional
- (void)moreSelectedBtnDidClick:(TableViewCellModel *)model key:(NSIndexPath *)key;

@end

@interface MoreSelectedTableViewCell : UITableViewCell

@property (nonatomic, assign) id<MoreSelectedTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *key;
@property (nonatomic, strong) TableViewCellModel *model;
@property (nonatomic, assign) UIColor *color;
@property (nonatomic, assign) BOOL isDetail;

- (void)hiddenLineView:(BOOL)isHidden;
///设置标题的宽度
- (void)settingTitleWidth:(CGFloat)width;
@end
