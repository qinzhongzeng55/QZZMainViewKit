//
//  SelectedTableViewCell.h
//  
//
//  Created by qinzhongzeng on 16/7/29.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QZZPublicModel/TableViewCellModel.h>
#import <QZZCategoryKit/UIImage+Extension.h>

@protocol SelectedTableViewCellDelegate <NSObject>

@optional
- (void)selectedBtnDidClick:(TableViewCellModel *)model key:(NSIndexPath *)key;

@end

typedef void (^selectedBtnDidClickBlock)(TableViewCellModel *model);

@interface SelectedTableViewCell : UITableViewCell

@property (nonatomic, assign) id<SelectedTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *key;
@property (nonatomic, strong) TableViewCellModel *model;
@property (copy, nonatomic) selectedBtnDidClickBlock selectedBtnDidClickBlock;
@property (nonatomic, assign) UIColor *color;
@property (nonatomic, assign) BOOL isDetail;

///隐藏lineView
- (void)hiddenLineView:(BOOL)isHidden;
///隐藏 >
- (void)hiddenMoreImageView:(BOOL)isHidden;
///设置标题的宽度
- (void)settingTitleWidth:(CGFloat)width;
@end
