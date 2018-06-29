//
//  QZZRefresh.m
//
//
//  Created by qinzhongzeng on 16/7/18.
//  Copyright © 2016年 qinzhongzeng. All rights reserved.
//

#import "QZZRefresh.h"
#import <QZZToolsKit/QZZProgressHUD.h>

@interface QZZRefresh()

///添加上拉加载/下拉刷新的tableView
@property (strong, nonatomic) UITableView *tableViewForRefresh;

@property (strong, nonatomic) MJRefreshBackGifFooter *footer;
@property (strong, nonatomic) MJRefreshNormalHeader *header;
@end

@implementation QZZRefresh

- (instancetype)init{

    if (self = [super init]) {
        [self setup];
    }
    return self;
}
/**
 *  初始化
 */
- (void)setup{

    _currentPage = 1;
}

- (void)addFooterRefreshWithTableView:(UITableView *)tableView{
    self.tableViewForRefresh = tableView;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefreshData)];
    self.footer = footer;
    if (self.color) {
        footer.stateLabel.textColor = self.color;
    }
    tableView.mj_footer = footer;
}
- (void)addHeaderRefreshWithTableView:(UITableView *)tableView{
    self.tableViewForRefresh = tableView;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefreshData)];
    self.header = header;
    if (self.color) {
        header.stateLabel.textColor = self.color;
        header.lastUpdatedTimeLabel.textColor = self.color;
    }
    tableView.mj_header = header;
}

- (void)upRefreshData{

    NSInteger page = 0;//总页数
    if (self.rowsInOnePage > 0) {//设置了每页的行数
        
        if (self.countForData % self.rowsInOnePage == 0) {
            page = self.countForData / self.rowsInOnePage;
        } else {
            page = self.countForData / self.rowsInOnePage + 1;
        }
        self.currentPage++;
        NSLog(@"刷新中当前页面:%ld",self.currentPage);
        if (self.currentPage > page) {//当前页码为最后一页时直接返回
            self.currentPage--;
            [QZZProgressHUD showMessage:@"没有更多数据了"];
            MJRefreshFooter *footer = self.tableViewForRefresh.mj_footer;
            [footer endRefreshing];
            return;
        }
    }
    [QZZProgressHUD showLoadingMessage:@"加载中..." toView:[UIApplication sharedApplication].keyWindow];
    if (self.upLoadDataBlock) {
        self.upLoadDataBlock(self.currentPage);
    }
    MJRefreshFooter *footer = self.tableViewForRefresh.mj_footer;
    [footer endRefreshing];
}

- (void)downRefreshData{
    
    //下拉刷新之后初始化当前页码
    self.currentPage = 1;//设置当前页码
    [QZZProgressHUD showLoadingMessage:@"加载中..." toView:[UIApplication sharedApplication].keyWindow];
    if (self.downLoadDataBlock) {
        self.downLoadDataBlock(self.currentPage);
    }
    MJRefreshHeader *header =  self.tableViewForRefresh.mj_header;
    [header endRefreshing];
}

- (void)setCurrentPage:(NSInteger)currentPage{

    _currentPage = currentPage;
    NSLog(@"设置当前页面属性:-->%ld",currentPage);
}
@end

