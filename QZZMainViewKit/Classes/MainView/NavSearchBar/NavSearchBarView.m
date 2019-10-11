//
//  NavSearchBarView.m
//
//
//  Created by 秦忠增 on 2018/4/28.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import "NavSearchBarView.h"

@interface NavSearchBarView ()<UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchBarLConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchBarRConstraint;
@end

@implementation NavSearchBarView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self settingSearchBar];
}

- (CGSize)intrinsicContentSize{
    return UILayoutFittingExpandedSize;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar setShowsCancelButton:NO animated:YES];
    self.searchString = searchBar.text;
    //刷新表格
    [self loadDataList];
    [self.searchBar resignFirstResponder];
    [self endEditing:YES];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{

    [searchBar setShowsCancelButton:NO animated:YES];
    // 修改UISearchBar右侧的取消按钮文字颜色及背景图片
    for (id obj in [searchBar.subviews[0] subviews]) {
        
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            
            UIButton *cancleButton = (UIButton *)obj;
            [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
            //[cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //[cancleButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        }
    }
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索框中的关键字:--->%@",searchBar.text);
    self.searchString = searchBar.text;
    [searchBar setShowsCancelButton:NO animated:YES];
    [self endEditing:YES];
    [self loadDataList];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    self.searchString = @"";
    searchBar.text = @"";
    [self.searchBar resignFirstResponder];
    [self endEditing:YES];
    [self loadDataList];
}
#pragma mark - 设置字体大小
- (void)settingTextSize:(CGFloat)textSize{
    for (UIView *subView in self.searchBar.subviews){
        for (UIView *secondLevelSubview in subView.subviews){
            if ([secondLevelSubview isKindOfClass:[UITextField class]]){
                UITextField *searchBarTextField = (UITextField *)secondLevelSubview;
                searchBarTextField.font = [UIFont boldSystemFontOfSize:textSize];
                //placeHolder文字设置
                searchBarTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入要搜索的关键字" attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:textSize]}];
                break;
            }
        }
    }
}
#pragma mark - 设置搜索框样式
- (void)settingSearchBar{
    self.searchBar.delegate = self;
    self.searchBar.backgroundImage = [UIImage new];
    self.searchBar.showsCancelButton = NO;
    self.searchBar.placeholder = @"请输入要搜索的关键字";
    for (UIView *subView in self.searchBar.subviews){
        for (UIView *secondLevelSubview in subView.subviews){
            if ([secondLevelSubview isKindOfClass:[UITextField class]]){
                UITextField *searchBarTextField = (UITextField *)secondLevelSubview;
                //placeHolder文字设置
                searchBarTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.searchBar.placeholder attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName : [UIColor colorWithWhite:204/255.0 alpha:1]}];
                break;
            }
        }
    }
    [self.searchBar setSearchFieldBackgroundImage:[UIImage new] forState:UIControlStateNormal];
    [self.searchBar setImage:[UIImage qzz_imagePathWithName:@"nav_search" bundle:@"QZZMainViewKit" targetClass:[self class]] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    self.searchBar.showsScopeBar = NO;
    self.searchBar.scopeBarBackgroundImage = [UIImage new];
    self.bgImageView.image = [UIImage qzz_imagePathWithName:@"nav_search_bg" bundle:@"QZZMainViewKit" targetClass:[self class]];
}
#pragma mark - 设置搜索框中的🔍图标
- (void)settingSearchBarIcon:(UIImage *)image{
    [self.searchBar setImage:image forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
}
#pragma mark - 设置搜索框中文本框的文本偏移量
- (void)settingSearchTextPositionAdjustment:(UIOffset)offset{
    self.searchBar.searchTextPositionAdjustment = offset;
}
#pragma mark - 风格颜色
- (void)settingTintColor:(UIColor *)color{
    self.searchBar.tintColor = color;
}
#pragma mark - 设置占位文字
- (void)settingPlaceHolder:(NSString *)placeHolder{
    self.searchBar.placeholder = placeHolder;
}
#pragma mark - 设置搜索框背景
- (void)settingBackgroundImage:(UIImage *)image{
    self.bgImageView.image = image;
    [self.searchBar setSearchFieldBackgroundImage:image forState:UIControlStateNormal];
}
#pragma mark - 设置搜索框左右两侧的间距
- (void)settingSearchBarLRConstratint:(CGFloat)constraint{
    self.searchBarLConstraint.constant = constraint;
    self.searchBarRConstraint.constant = constraint;
}
#pragma mark - 更新数据
- (void)loadDataList{
    if ([self.delegate respondsToSelector:@selector(loadDataList)]) {
        [self.delegate loadDataList];
    }
}
#pragma mark - 开始编辑
- (void)beginEditing{
    [self.searchBar becomeFirstResponder];
}
#pragma mark - 结束编辑
- (void)endEditing{
    [self endEditing:YES];
    [self.searchBar resignFirstResponder];
}
#pragma mark - setter,getter
- (void)setSearchString:(NSString *)searchString{
    _searchString = searchString;
    if ([searchString isEqualToString:@""]) {
        self.searchBar.text = @"";
    }
}
@end
