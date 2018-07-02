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
@end
