//
//  ScrollOptionsView.h
//  WQYL_SYS
//
//  Created by 秦忠增 on 2018/4/23.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QZZMainViewKit.h"

@protocol ScrollOptionsViewDelegate <NSObject>

@optional
///选择这个选项
- (void)selectedThisOption:(NSIndexPath *)key;

@end
@interface ScrollOptionsView : UITableViewCell

@property (nonatomic, assign) id<ScrollOptionsViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
//默认选中(设置完dataArray之后设置默认选中,之后再设置lineView)
@property (nonatomic, strong) NSIndexPath *selectedKey;
/**
 线长度(请在设置选项字体前设置lineWidth(原因为需要根据font自动计算最大长度,若不先设置lineView的话lineView的值会无效),设置默认选中之后再设置lineView)
 */
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *lineColor;

///滚动到指定的列
- (void)scrollToIndexPath:(NSIndexPath *)key;
/**
 * 设置选项字体
 * 若不想设置最大文本宽度为lineView的话,请设置选项字体之前先设置想要的lineView;
 * 若想设置最大文本宽度为lineView的话,设置选项字体之前不要设置lineView;
 */
- (void)settingOptionTitleColor:(UIColor *)color selectedColor:(UIColor *)selectedColor font:(UIFont *)font;
@end
