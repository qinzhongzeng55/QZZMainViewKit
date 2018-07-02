//
//  SearchOptionsListView.h
//  
//  带搜索框的下拉选择框
//  Created by qinzhongzeng on 16/7/27.
//  Copyright © 2016年 qinzhongzeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionsListTableViewCell.h"
#import "QZZMainViewKit.h"

///选项选中后执行的block
typedef void (^OptionSelectedBlock)(OptionButtonModel *model,NSIndexPath *key);

@interface SearchOptionsListView : UIView

///选项数组
@property (nonatomic, strong) NSMutableArray *dataArray;
///搜索占位标题
@property (nonatomic, copy) NSString *searchPlaceholder;
///选项选中后执行的block
@property (nonatomic, copy) OptionSelectedBlock OptionSelectedBlock;

@property (nonatomic, strong) NSIndexPath *key;


///设置头部lineView的背景颜色
- (void)settingBackgroundColorOfTopView:(UIColor *)color;
@end
