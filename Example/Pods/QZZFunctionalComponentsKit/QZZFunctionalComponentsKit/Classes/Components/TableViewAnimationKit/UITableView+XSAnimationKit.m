//
//  UITableView+XSAnimationKit.m
//  
//
//  Created by 秦忠增 on 2018/4/20.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import "UITableView+XSAnimationKit.h"
#import "TableViewAnimationKit.h"

@implementation UITableView (XSAnimationKit)

- (void)xs_showTableViewAnimationWithType:(XSTableViewAnimationType)animationType{
    [TableViewAnimationKit showWithAnimationType:animationType tableView:self];
}

@end
