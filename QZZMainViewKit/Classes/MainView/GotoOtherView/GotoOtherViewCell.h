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

//隐藏底部的line
- (void)hiddenLineView:(BOOL)isHidden;
//设置选项文本
- (void)settingTitleView:(NSString *)title;
@end
