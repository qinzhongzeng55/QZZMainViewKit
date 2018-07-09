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
@end
