//
//  QZZViewController.m
//  
//
//  Created by qinzhongzeng on 2016/10/12.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import "QZZViewController.h"

@interface QZZViewController ()<NavSearchBarViewDelegate>

@property (nonatomic, strong) UILabel *titleLabelOfEmptyContentView;
@property (nonatomic, strong) UIImageView *bgImgOfEmptyContentView;
@property (nonatomic, strong) UILabel *titleLabelOfErrorView;
@property (nonatomic, strong) UIImageView *bgImgOfErrorView;
@end

@implementation QZZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = QZZUIColorWithWhite(238);
    //加载子视图
    [self loadSubViews];
    //设置导航栏
    [self setupNavType];
    //解决滚动视图无故偏移
    [self adjustsScrollViewScrollViewInsets];
    
    //隐藏导航栏阴影视图
    self.contentLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    self.contentLineImageView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //获取阴影视图
    self.contentLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    self.contentLineImageView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    //显示阴影视图
    self.contentLineImageView.hidden = NO;
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
///更新数据
- (void)updateData{
    
}
#pragma mark - 解决滚动视图无故偏移
- (void)adjustsScrollViewScrollViewInsets{
    //解决滚动视图无故偏移
    if (@available(iOS 11.0, *)) {
        // iOS 11 及其以上系统运行
        if (self.scrollView != nil) {
            self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    } else {
        //解决滚动视图无故偏移
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - 设置导航栏左侧的返回按钮
- (void)setupNavType{
    
    //设置导航栏左侧按钮
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
#pragma mark - ********获取阴影视图********
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            
            return imageView;
        }
    }
    return nil;
}

#pragma mark - method
/**
 *  导航栏上返回按钮的回调
 */
- (void)backItemDidClick{
    
    [self.navigationController popViewControllerAnimated:NO];
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
    UIView *EmptyContentView = [[UIView alloc] initWithFrame:CGRectMake(0,y, Screen_Width, Screen_Height-y)];
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
#pragma mark - 设置状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    if (self.isStatusBarLight) {
        return UIStatusBarStyleLightContent;
    }else{
        return UIStatusBarStyleDefault;
    }
}
#pragma mark - ------加载控件------
- (void)loadSubViews{
    
    //加载快捷功能(例如:回到顶部等)
    [self loadKuaiJieCaoZuoView];
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

}
#pragma mark - 结束编辑状态
- (void)endEditing{
    [self.view endEditing:YES];
    [self.navSearchBarView endEditing];
}
#pragma mark - 加载提示框
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
#pragma mark - setter,getter
- (NavSearchBarView *)navSearchBarView{
    if (_navSearchBarView == nil) {
        _navSearchBarView = QZZGetNibFile_SecondaryBundle(@"QZZMainViewKit",@"NavSearchBarView");
        _navSearchBarView.delegate = self;
    }
    return _navSearchBarView;
}
@end
