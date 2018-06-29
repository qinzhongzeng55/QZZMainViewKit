//
//  QZZCellProtocol.h
//  
//
//  Created by qinzhongzeng on 2017/9/10.
//  Copyright © 2017年 Triangle. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QZZCellProtocol <NSObject>

@optional;
/// tableView中点击cell的代理
- (void)cellDidClick:(NSIndexPath *)indexPath params:(NSDictionary *)params;

@end
