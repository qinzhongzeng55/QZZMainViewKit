//
//  QZZRefresh.h
//  刷新控件

//  Created by qinzhongzeng on 16/7/18.
//  Copyright © 2016年 qinzhongzeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJRefresh/MJRefresh.h>

///下拉刷新的回调
typedef void(^QZZRefreshDownLoadBlock)(NSInteger currentPage);
///上拉加载的回调
typedef void(^QZZRefreshUpLoadBlock)(NSInteger currentPage);

@interface QZZRefresh : NSObject
//  ==================注释说明====================
//                      ||
//                      ||
//                      ||
//                     \\//
//                      \/
#warning            记得设置以下参数
//  =============================================
///总行数
@property (assign, nonatomic) NSInteger countForData;
///每页数据的条数
@property (assign, nonatomic) NSInteger rowsInOnePage;
///数据请求的地址
@property (assign, nonatomic) NSString *urlString;
@property (copy, nonatomic) QZZRefreshDownLoadBlock downLoadDataBlock;
@property (copy, nonatomic) QZZRefreshUpLoadBlock upLoadDataBlock;
///请求参数
@property (strong, nonatomic) NSMutableDictionary *params;
//  =============================================
//                        /\
//                       //\\
//                        ||
//                        ||
#warning            记得设置以上参数
//  =============================================
///当前页码
@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) UIColor *color;
/**
 *  上拉加载
 *  @param tableView                    需要添加上拉加载的tableView
 */
- (void)addFooterRefreshWithTableView:(UITableView *)tableView;
/**
 *  下拉刷新
 *  @param tableView                需要添加下拉刷新的tableView
 */
- (void)addHeaderRefreshWithTableView:(UITableView *)tableView;
@end
