//
//  UITableViewCell+QZZAdd.h
//
//
//  Created by qinzhongzeng on 2017/8/24.
//  Copyright © 2017年 Triangle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QZZCellProtocol.h"

@interface UITableViewCell (QZZAdd)

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) NSDictionary *dataDict;
@property (nonatomic, weak) id<QZZCellProtocol> delegate;

@end
