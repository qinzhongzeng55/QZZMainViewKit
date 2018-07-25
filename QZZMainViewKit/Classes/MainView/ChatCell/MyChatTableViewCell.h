//
//  MyChatTableViewCell.h
//  聊天记录-我的
//
//  Created by 秦忠增 on 2018/7/10.
//  Copyright © 2018年 wanqianyanglao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QZZPublicModel/ChatInfoModel.h>
#import "QZZMainViewKit.h"

@interface MyChatTableViewCell : UITableViewCell

@property (nonatomic, strong) ChatInfoModel *model;
@end
