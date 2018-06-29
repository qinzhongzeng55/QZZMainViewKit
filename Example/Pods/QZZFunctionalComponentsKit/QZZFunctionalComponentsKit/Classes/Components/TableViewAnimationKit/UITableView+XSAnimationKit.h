//
//  UITableView+XSAnimationKit.h
//  
//
//  Created by 秦忠增 on 2018/4/20.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewAnimationKitConfig.h"

@interface UITableView (XSAnimationKit)

/**
 show the tableView animation 
 
 @param animationType type of animation to show TableView
 */
- (void)xs_showTableViewAnimationWithType:(XSTableViewAnimationType )animationType;


@end
