//
//  QZZListViewController.m
//
//
//  Created by qinzhongzeng on 16/8/22.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import "QZZListViewController.h"

@interface QZZListViewController ()<UISearchBarDelegate,NavSearchBarViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UILabel *titleLabelOfEmptyContentView;
@property (nonatomic, strong) UILabel *titleLabelOfErrorView;
@property (nonatomic, strong) UIImageView *bgImgOfEmptyContentView;
@property (nonatomic, strong) UIImageView *bgImgOfErrorView;

@end

@implementation QZZListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = QZZUIColorWithWhite(238);
    //设置动态显示列表项时的样式
    self.animationType = XSTableViewAnimationTypeMoveSpringToLeft;
    //加载子视图
    [self loadSubViews];
    //导航栏样式
    [self setupNavType];
    //获取阴影视图
    self.contentLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    self.contentLineImageView.hidden = YES;
    //解决滚动视图无故偏移
    [self adjustsScrollViewScrollViewInsets];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    [self endEditing];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:  0.32 animations:^{
        weakSelf.gotoTopBtn.transform = CGAffineTransformMakeTranslation(0, 120);
        weakSelf.gotoTopBtn.hidden = YES;
    }];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //滚动超过一屏时显示回到顶部按钮
    [self showGotoTopBtn:scrollView];    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self showGotoTopBtn:scrollView];
}

///滚动超过一屏时显示回到顶部按钮
- (void)showGotoTopBtn:(UIScrollView *)scrollView{
    CGFloat y = NAV_HEIGHT;
    CGFloat h = TABBAR_HEIGHT;
    if(scrollView.contentOffset.y >= (Screen_Height-y-h)*0.5){
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration: 0.32 animations:^{
            weakSelf.gotoTopBtn.hidden = NO;
            weakSelf.gotoTopBtn.transform = CGAffineTransformIdentity;
        }];
    }else{
        self.gotoTopBtn.hidden = YES;
    }
}
#pragma mark - NavSearchBarViewDelegate
///根据关键字搜索数据
- (void)loadDataList{
    [self updateData];
}
#pragma mark - 解决滚动视图无故偏移
- (void)adjustsScrollViewScrollViewInsets{
    //解决滚动视图无故偏移
    if (@available(iOS 11.0, *)) {
        // iOS 11 及其以上系统运行
        if (self.tableView != nil) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    } else {
        //解决滚动视图无故偏移
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
#pragma mark - 设置导航栏样式
- (void)setupNavType{

    //-----导航条左侧按钮----//
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage qzz_imagePathWithName:@"nav_back" bundle:@"QZZMainViewKit" targetClass:[self class]] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backItemDidClick) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 40, 40);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}
- (void)setupNavSearchBar{
    self.navSearchBarView.frame = CGRectMake(0, 0, Screen_Width-136, 44);
    self.navigationItem.titleView = self.navSearchBarView;
}
///设置搜索框左右两侧的间距
- (void)settingSearchBarLRConstratint:(CGFloat)constraint{
    [self.navSearchBarView settingSearchBarLRConstratint:constraint];
}
#pragma mark - ----------method----------
#pragma mark  ------返回按钮点击-----
/**
 *  返回按钮点击
 */
- (void)backItemDidClick{

    [self.navigationController popViewControllerAnimated:NO];
}

- (void)updateData{

    [super updateData];
    self.upLoadRefresh.rowsInOnePage = self.rowsNumInOnePage;
    self.upLoadRefresh.countForData = self.RowsCountForData;
    self.downLoadRefresh.rowsInOnePage = self.rowsNumInOnePage;
    self.downLoadRefresh.countForData = self.RowsCountForData;
}
#pragma mark  ------刷新数据-----
- (void)reloadData{
    
    [self.tableView reloadData];
}

#pragma mark ------过滤------
- (void)guolv{
    
    BOOL isGuolv = self.isGuolv;
    self.isGuolv = !isGuolv;
    __weak typeof(self) weakSelf = self;
    if (self.isGuolv) {
        [UIView animateWithDuration:0.3 animations:^{
            
            weakSelf.filterOptionsView.frame =  CGRectMake(0, CGRectGetMaxY(weakSelf.searchBarView.frame) , Screen_Width, 132);
            CGFloat y = CGRectGetMaxY(weakSelf.filterOptionsView.frame);
            weakSelf.optionListView.frame = CGRectMake(0, y, Screen_Width, Screen_Height - y - weakSelf.bottomToolsView.frame.size.height);
            weakSelf.bottomToolsView.frame = CGRectMake(0, Screen_Height - 49, Screen_Width, 49);
            [weakSelf.view layoutIfNeeded];
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            
            weakSelf.filterOptionsView.frame =  CGRectMake(0, CGRectGetMaxY(weakSelf.searchBarView.frame) , Screen_Width, 0);
            CGFloat y = CGRectGetMaxY(weakSelf.filterOptionsView.frame);
            weakSelf.optionListView.frame = CGRectMake(0, y, Screen_Width, Screen_Height - y - weakSelf.bottomToolsView.frame.size.height);
            weakSelf.bottomToolsView.frame = CGRectMake(0, Screen_Height, Screen_Width, 49);
            [weakSelf.view layoutIfNeeded];
        }];
    }
}
#pragma mark - ------加载控件------
- (void)loadSubViews{
    //加载搜索框
    [self loadSearchBar];
    //加载功能按钮
    [self loadOptionsBtnView];
    //加载过滤功能按钮
    [self loadFilterOptionsView];
    //加载底部工具条
    [self loadBottomToolBar];
    //加载数据列表容器
    [self loadOptionListView];
    //加载数据列表
    [self loadOptionsListTableView];
    //加载下拉刷新控件
    [self loadRefresh];
    //加载快捷功能(例如:回到顶部等)
    [self loadKuaiJieCaoZuoView];
    //加载空页面
    [self setupEmptyContentView];
    //加载获取失败时的页面
    [self setupGetErrorView];
}
#pragma mark ---上拉加载/下拉刷新---
- (void)loadRefresh{
    
    __weak typeof(self) weakSelf = self;
    self.upLoadRefresh = [[QZZRefresh alloc] init];
    self.upLoadRefresh.currentPage = 1;
    [self.upLoadRefresh addFooterRefreshWithTableView:self.tableView];
    self.upLoadRefresh.upLoadDataBlock = ^(NSInteger currentPage) {
        if (weakSelf.upLoadDataBlock) {
            weakSelf.upLoadDataBlock(currentPage);
        }
    };
    self.downLoadRefresh = [[QZZRefresh alloc] init];
    self.downLoadRefresh.currentPage = 1;
    [self.downLoadRefresh addHeaderRefreshWithTableView:self.tableView];
    self.downLoadRefresh.downLoadDataBlock = ^(NSInteger currentPage) {
        if (weakSelf.downLoadDataBlock) {
            weakSelf.downLoadDataBlock(currentPage);
        }
    };
}

#pragma mark ---加载搜索框---
- (void)loadSearchBar{
    CGFloat y = NAV_HEIGHT;
    self.searchBarView.frame = CGRectMake(0, y, Screen_Width, 44);
    self.searchBar.frame = self.searchBarView.bounds;
    [self.view addSubview:self.searchBarView];
}
#pragma mark ---加载功能按钮---
- (void)loadOptionsBtnView{

    self.optionsBtnView.frame = CGRectMake(0, 0, Screen_Width, 0);
    [self.view addSubview:self.optionsBtnView];
}
#pragma mark ---加载过滤选项---
- (void)loadFilterOptionsView{
    
    self.filterOptionsView.frame = CGRectMake(0, CGRectGetMaxY(self.searchBarView.frame) , Screen_Width, 0);
    [self.view addSubview:self.filterOptionsView];
}
#pragma mark ---加载底部工具条---
- (void)loadBottomToolBar{
    
    self.bottomToolsView.frame = CGRectMake(0, Screen_Height, Screen_Width, 0);
    [self.view addSubview:self.bottomToolsView];
}
#pragma mark ---加载数据列表容器---
- (void)loadOptionListView{
    
    CGFloat y = CGRectGetMaxY(self.filterOptionsView.frame);
    self.optionListView.frame = CGRectMake(0, y, Screen_Width, Screen_Height - y - self.bottomToolsView.frame.size.height);
    self.tableView.frame = self.optionListView.bounds;
    [self.view addSubview:self.optionListView];
}
#pragma mark ---加载数据列表---
- (void)loadOptionsListTableView{
    
    self.tableView.frame = self.optionListView.bounds;
    [self.optionListView addSubview:self.tableView];
}
#pragma mark - ---设置无数据页面---
- (void)hiddenEmptyContentView:(BOOL)isHidden{
    
    self.EmptyContentView.hidden = isHidden;
}
- (void)settingBgImgWithImgNameOfEmptyContentView:(NSString *)imgName{

    self.bgImgOfEmptyContentView.image = [UIImage imageNamed:imgName];
}
- (void)settingTitleOfEmptyContentView:(NSString *)title{
    
    self.titleLabelOfEmptyContentView.text = title;
}
- (void)settingTitleColorOfEmptyContentView:(UIColor *)color{
    
    self.titleLabelOfEmptyContentView.textColor = color;
}
- (void)hiddenGotoAddBtn:(BOOL)isHidden{
    
    self.gotoAddBtn.hidden = isHidden;
}
- (void)setupEmptyContentView{
    CGFloat y = NAV_HEIGHT;
    UIView *EmptyContentView = [[UIView alloc] initWithFrame:CGRectMake(0,y, Screen_Width, self.tableView.frame.size.height)];
    EmptyContentView.backgroundColor = QZZUIColorWithWhite(255);
    self.EmptyContentView = EmptyContentView;
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage qzz_imagePathWithName:@"data_empty" bundle:@"QZZMainViewKit" targetClass:[self class]]];
    img.frame  = CGRectMake((Screen_Width - 213)*0.5, (EmptyContentView.bounds.size.height - 213-30-58)*0.5, 213, 213);
    self.bgImgOfEmptyContentView = img;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(img.frame), Screen_Width, 30)];
    label.text = @"您还没有客户,快去新建吧";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = QZZUIColorWithRGB(102, 102, 102);
    self.titleLabelOfEmptyContentView = label;
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake((Screen_Width-120)*0.5, CGRectGetMaxY(label.frame)+20, 120, 38);
    [addBtn setBackgroundColor:QZZUIColorWithRGB(58,156, 241)];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn setTitle:@"新建客户" forState:UIControlStateNormal];
    addBtn.layer.cornerRadius = 5;
    addBtn.layer.masksToBounds = YES;
    [addBtn addTarget:self action:@selector(gotoAdd) forControlEvents:UIControlEventTouchUpInside];
    self.gotoAddBtn = addBtn;
    [EmptyContentView addSubview:img];
    [EmptyContentView addSubview:label];
    [EmptyContentView addSubview:addBtn];
    self.EmptyContentView.hidden = YES;
    [self.view addSubview:self.EmptyContentView];
}
- (void)gotoAdd{
    DLog(@"去新建...");
}
///重新布局空页面
- (void)layoutSubviewsForEmptyContentView{
    self.bgImgOfEmptyContentView.frame = CGRectMake((Screen_Width - 213)*0.5, (self.EmptyContentView.bounds.size.height - 213-30-58)*0.5, 213, 213);
    self.titleLabelOfEmptyContentView.frame = CGRectMake(0, CGRectGetMaxY(self.bgImgOfEmptyContentView.frame), Screen_Width, 30);
    self.gotoAddBtn.frame = CGRectMake((Screen_Width-120)*0.5, CGRectGetMaxY(self.titleLabelOfEmptyContentView.frame)+20, 120, 38);
}
#pragma mark - 加载失败时的页面
- (void)hiddenGetError:(BOOL)isHidden{
    
    self.errorView.hidden = isHidden;
}

- (void)setupGetErrorView{
    CGFloat y = NAV_HEIGHT;
    UIView *errorView = [[UIView alloc] initWithFrame:CGRectMake(0,y, Screen_Width, Screen_Height-y)];
    errorView.backgroundColor = [UIColor colorWithWhite:255/255.0 alpha:1];
    self.errorView = errorView;
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_icon_defeated"]];
    img.frame  = CGRectMake((Screen_Width - 169)*0.5, (errorView.bounds.size.height - 223-30-38)*0.5, 169, 223);
    self.bgImgOfErrorView = img;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(img.frame), Screen_Width, 30)];
    label.text = @"由于网络原因,加载失败";
    self.titleLabelOfErrorView = label;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = QZZUIColorWithRGB(102, 102, 102);
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshBtn.frame = CGRectMake((Screen_Width-120)*0.5, CGRectGetMaxY(label.frame), 120, 38);
    refreshBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [refreshBtn setTitleColor:QZZUIColorWithRGB(58, 156, 241) forState:UIControlStateNormal];
    [refreshBtn setTitle:@"重新加载" forState:UIControlStateNormal];
    [refreshBtn setImage:[UIImage imageNamed:@"home_btn_loading"] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(refreshBtnLoad) forControlEvents:UIControlEventTouchUpInside];
    [errorView addSubview:refreshBtn];
    self.refreshBtn = refreshBtn;
    [errorView addSubview:img];
    [errorView addSubview:label];
    self.errorView.hidden = YES;
    [self.view addSubview:self.errorView];
}
- (void)refreshBtnLoad{
    DLog(@"重新加载数据中...");
}
///重新布局失败时的页面
- (void)layoutSubviewsForGetErrorView{
    
    CGFloat y = NAV_HEIGHT;
    self.errorView.frame = CGRectMake(0,y, Screen_Width, Screen_Height-y);
    self.bgImgOfErrorView.frame = CGRectMake((Screen_Width - 169)*0.5, (self.errorView.frame.size.height - (223+30+38))*0.5, 169, 223);
    self.titleLabelOfErrorView.frame = CGRectMake(0, CGRectGetMaxY(self.bgImgOfErrorView.frame), Screen_Width, 30);
    self.refreshBtn.frame = CGRectMake((Screen_Width-120)*0.5, CGRectGetMaxY(self.titleLabelOfErrorView.frame)+10, 120, 38);
}
///设置失败时页面的大小
- (void)settingErrorViewFrame:(CGRect)frame{
    self.errorView.frame = frame;
    self.bgImgOfErrorView.frame = CGRectMake((Screen_Width - 169)*0.5, (self.errorView.frame.size.height - (223+30+38))*0.5, 169, 223);
    self.titleLabelOfErrorView.frame = CGRectMake(0, CGRectGetMaxY(self.bgImgOfErrorView.frame), Screen_Width, 30);
    self.refreshBtn.frame = CGRectMake((Screen_Width-120)*0.5, CGRectGetMaxY(self.titleLabelOfErrorView.frame)+10, 120, 38);
}
#pragma mark - ------添加快捷功能按钮------
- (void)loadKuaiJieCaoZuoView{
    //加载回到顶部按钮
    [self setupGotoTopBtn];
}

#pragma mark ---加载回到顶部按钮---
- (void)setupGotoTopBtn{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat h = TABBAR_HEIGHT;
    button.frame = CGRectMake(Screen_Width-50-32, Screen_Height-50-h-10, 50.f, 50.f);
    [button setBackgroundImage:[UIImage qzz_imagePathWithName:@"gotoTop" bundle:@"QZZMainViewKit" targetClass:[self class]] forState:UIControlStateNormal];
    button.layer.cornerRadius = 25;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(gotoTopBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    button.hidden = YES;
    self.gotoTopBtn = button;
    [self.view addSubview:button];
}

- (void)gotoTopBtnDidClick{

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.32 animations:^{
        weakSelf.gotoTopBtn.transform = CGAffineTransformMakeTranslation(0, 120);
        weakSelf.gotoTopBtn.hidden = YES;
    } completion:^(BOOL finished) {
        if ([weakSelf.tableView numberOfSections] > 0 && [weakSelf.tableView numberOfRowsInSection:0] > 0) {
            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }];
}

#pragma mark - 动态显示列表项
- (void)starAnimationWithTableView:(UITableView *)tableView {
    
    [TableViewAnimationKit showWithAnimationType:self.animationType tableView:tableView];
}

#pragma mark - 显示提示框
- (void)tishi:(NSString *)title{
    CGFloat y = NAV_HEIGHT;
    __block UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((Screen_Width / 2 - 150), y+10, 300, 30)];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 5;
    label.backgroundColor = [UIColor colorWithWhite:0/255.0 alpha:0.6];
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    [self.view bringSubviewToFront:label];
    [UIView animateWithDuration:0.5f animations:^{
        label.alpha = 0.9f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:3.5f animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
            label = nil;
        }];
    }];
}
#pragma mark - 结束编辑状态
- (void)endEditing{
    [self.searchBar resignFirstResponder];
    [self.view endEditing:YES];
    [self.navSearchBarView endEditing];
}
#pragma mark - 懒加载
- (UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (void)setDataArray:(NSMutableArray *)dataArray{
    
    _dataArray = dataArray;
    [self reloadData];
    [self starAnimationWithTableView:self.tableView];
}

- (NavSearchBarView *)navSearchBarView{
    if (_navSearchBarView == nil) {
        _navSearchBarView = QZZGetNibFile_SecondaryBundle(@"QZZMainViewKit",@"NavSearchBarView");
        _navSearchBarView.delegate = self;
    }
    return _navSearchBarView;
}
@end
