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

///设置头像
- (void)settingIconImage:(UIImage *)image;
///设置聊天内容背景图片
- (void)settingChatContentBGImage:(UIImage *)image;
@end
