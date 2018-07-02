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
//默认选中
@property (nonatomic, strong) NSIndexPath *selectedKey;
///线长度
@property (nonatomic, assign) CGFloat lineWidth;

///滚动到指定的列
- (void)scrollToIndexPath:(NSIndexPath *)key;
@end
