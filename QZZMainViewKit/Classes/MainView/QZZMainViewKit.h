//
//  QZZMainViewKit.h
//
//
//  Created by qinzhongzeng on 2017/7/11.
//  Copyright © 2017年 qinzhongzeng. All rights reserved.
//

#ifdef __OBJC__

#import <UIKit/UIKit.h>

//! Project version number for QZZMainViewKit.
FOUNDATION_EXPORT double QZZMainViewKitVersionNumber;

//! Project version string for QZZMainViewKit.
FOUNDATION_EXPORT const unsigned char QZZMainViewKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <QZZMainViewKit/PublicHeader.h>

#import <QZZCategoryKit/UIColor+Hex.h>

#endif

//******************************************************************
#pragma mark -  ********************  常用宏定义  *******************
//******************************************************************
///文本行间距
#define LineSpacing 10.f
///文本字间距
#define WordsSpacing 0.5f
//******************************************************************
#pragma mark -  ********************  调试打印 *******************
//******************************************************************

///打印log
#ifdef DEBUG

#define DLog(FORMAT,...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else

#define DLog(...)

#endif

/**
 *  @brief 控制台输出CGRect的信息
 *  @param rect 要输出信息的CGRect
 */
#define DLog_cgRect(rect) LKLog(@"%s W:%.4f, Y:%.4f, W:%.4f, H:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)

/**
 *  @brief 控制台输出CGSize的信息
 *  @param rect 要输出信息的CGSize
 */
#define DLog_cgSize(size) LKLog(@"%s W:%.4f, H:%.4f", #size, size.width, size.height)

/**
 *  @brief 控制台输出CGPoint的信息
 *  @param rect 要输出信息的CGPoint
 */
#define DLog_cgPoint(point) LKLog(@"%s X:%.4f, Y:%.4f", #point, point.x, point.y)


//******************************************************************
#pragma mark -  ***************  解决滚动视图无故偏移  **************
//******************************************************************
/*
 在iOS11设备上运行出现最多问题应该就是tableview莫名奇妙的偏移20pt或者64pt了。原因是iOS11弃用了automaticallyAdjustsScrollViewInsets属性，取而代之的是UIScrollView新增了contentInsetAdjustmentBehavior属性，这一切的罪魁祸首都是新引入的safeArea
 */
#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
if (scrollView != nil) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
}\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)



///去除首尾空格
#define allTrim(object) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]

///把角度转换成PI的方式
#define degressToRadius(ang) (M_PI*(ang)/180.0f)

///拼装请求地址
#define kWebPZRequestURLString(serviceUrlString,urlString) [NSString stringWithFormat:@"%@%@",serviceUrlString,urlString]

//******************************************************************
#pragma mark -  ********************  屏幕尺寸  *******************
//******************************************************************
#define Screen_Width [[UIScreen mainScreen] bounds].size.width
#define Screen_Height [[UIScreen mainScreen] bounds].size.height

//******************************************************************
#pragma mark -  ****************  获取系统或app信息  ***************
//******************************************************************
///当前系统版本
#define CurrentSystemVersion  [UIDevice currentDevice].systemVersion.floatValue
///当前app版本号
#define CurrentAppVersion  [[[NSBundle mainBundle] infoDictionary]  objectForKey:@"CFBundleShortVersionString"]

//******************************************************************
#pragma mark -  ********************  UIColor  *******************
//******************************************************************
/**
 根据颜色值来创建颜色，颜色值范围为0-255，透明度为0-1的小数
 
 @param red 红色颜色值
 @param green 绿色颜色值
 @param blue 蓝色颜色值
 @param alpha 透明度值
 @return 生成的颜色对象
 */
#define QZZUIColorWithRGBAndAlpha(red,green,blue,alpha) [UIColor colorWithRed: red / 255.0 green: green / 255.0 blue: blue / 255.0 alpha: alpha]

/**
 根据十六进制的字符串来生成颜色对象
 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 颜色值范围0-1的小数
 
 @param hexString 十六进制颜色值字符串
 @param alpha 透明度的值
 @return 生成的颜色对象
 */
#define QZZUIColorWithHexString(hexString,alpha) [UIColor colorWithHexString: hexString alpha: alpha]

/**
 根据十六进制的字符串来生成不透明的颜色对象
 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 
 @param hexString 十六进制颜色值字符串
 @return 生成的颜色对象
 */
#define QZZUIColorWithHexStringNoTransparent(hexString) [UIColor colorWithHexString: hexString]
///根据RGB值获取UIColor
#define QZZUIColorWithRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define QZZUIColorWithWhite(w) [UIColor colorWithWhite:w/255.0 alpha:1]

#define QZZUIColorWithWhiteAndAlpha(w,alpha) [UIColor colorWithWhite:w/255.0 alpha:alpha]


//******************************************************************
#pragma mark -  *****************  获取常用window  ****************
//******************************************************************
///顶部Window
#define QZZLastWindow [UIApplication sharedApplication].windows.lastObject
///keyWindow
#define QZZKeyWindow [UIApplication sharedApplication].keyWindow
//******************************************************************
#pragma mark -  **************  获取通过xib创建的view  *************
//******************************************************************
//----------------获取主app中xib创建的view----------------//
#define QZZGetNibFile(NibName) [[[NSBundle mainBundle] loadNibNamed:NibName owner:nil options:nil] lastObject]
//----------获取主app以外的其他组件中xib创建的view----------//
///获取MainBundle通过xib创建的view
#define QZZGetNibFile_MainBundle(NibName) [[[NSBundle bundleForClass:[self class]] loadNibNamed:NibName owner:nil options:nil] lastObject]
///获取二级bundle中通过xib创建的view(BundleName---二级bundle名称不带".bundle")
#define QZZGetNibFile_SecondaryBundle(BundleName,NibName) [[[NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle",BundleName]]] loadNibNamed:NibName owner:nil options:nil] lastObject]

//******************************************************************
#pragma mark -  *****************  导航栏和tabbar  ****************
//******************************************************************
///导航栏高度
#define NAV_HEIGHT (iPhoneX == 1) ? 88.0f : 64.0f
///tabBar高度
#define TABBAR_HEIGHT (iPhoneX == 1) ? 83.0f : 49.0f
///底部安全高度
#define BottomSafeHeight 34

//******************************************************************
#pragma mark -  ***********  拼接NSBundle中的图片资源路径  **********
//******************************************************************
//----------------------调用主app的二级Bundle中的图片资源----------------------//
#define MYBUNDLE_Path(BundleName) [[NSBundle mainBundle] pathForResource:BundleName ofType:nil]

#define MYBUNDLE_ImagePath(BundleName,ImageName) [MYBUNDLE_Path(BundleName) stringByAppendingPathComponent:ImageName]

//----------------调用主app以外的其他组件中的图片资源----------------//
//----------调用主app以外的其他组件的MainBundle中的图片资源----------//
#define MYBUNDLE_MainBundle(BundleName,ImageName) [[NSBundle bundleForClass:[self class]] stringByAppendingPathComponent:ImageName]

//----------调用主app以外的其他组件的二级Bundle中的图片资源----------//
#define MYBUNDLE_Path_SecondaryBundle(BundleName) [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle",BundleName]]]

#define MYBUNDLE_SecondaryBundle_ImagePath(BundleName,ImageName) [MYBUNDLE_Path_SecondaryBundle(BundleName) stringByAppendingPathComponent:ImageName]



//******************************************************************
#pragma mark -  ********************* 通知相关  ********************
//******************************************************************
// 通知中心
#define QZZNotificationCenter [NSNotificationCenter defaultCenter]

//******************************************************************
#pragma mark -  ********************  常用机型  *******************
//******************************************************************
// iPhone4s 3.5英寸 屏幕宽高：320*480点 屏幕模式：2x 分辨率：640*960像素
#define iPhone4s ([UIScreen mainScreen].bounds.size.height == 480.0) ? YES : NO

// iPhone5/5c/5s/SE 4英寸 屏幕宽高：320*568点 屏幕模式：2x 分辨率：640*1136像素
#define iPhone5or5cor5sorSE ([UIScreen mainScreen].bounds.size.height == 568.0) ? YES : NO

// iPhone6/6s/7 4.7英寸 屏幕宽高：375*667点 屏幕模式：2x 分辨率：750*1334像素
#define iPhone6or6sor7 ([UIScreen mainScreen].bounds.size.height == 667.0) ? YES : NO

// iPhone6 Plus/6s Plus/7 Plus 5.5英寸 屏幕宽高：414*736点 屏幕模式：3x 分辨率：1242*2208像素
#define iPhone6Plusor6sPlusor7Plus ([UIScreen mainScreen].bounds.size.height == 736.0) ? YES : NO

// iPhoneX 屏幕宽高：375*812点 屏幕模式：3x 分辨率：1125*2436像素
#define iPhoneX ([UIScreen mainScreen].bounds.size.height == 812.0) ? YES : NO

//******************************************************************
#pragma mark -  *******************  导入公共头文件  *****************
//******************************************************************
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

//宏定义, 必须放到 头文件前, 不然不会生效

#import <Masonry/Masonry.h>
#import <QZZCategoryKit/UIImage+Extension.h>
#import <QZZCategoryKit/NSArray+Log.h>
#import <QZZCategoryKit/NSString+Emoji.h>
#import <QZZCategoryKit/UIButton+Extension.h>
#import <QZZCategoryKit/UIImage+ImageEffects.h>
#import <QZZCategoryKit/UILabel+ChangeLineSpaceAndWordSpace.h>
#import <QZZCategoryKit/UILabel+Extension.h>
#import <QZZCategoryKit/UIView+QZZFrame.h>

#import <QZZToolsKit/QZZCoreArchive.h>
#import <QZZToolsKit/QZZFileOperation.h>
#import <QZZToolsKit/QZZNSDateTools.h>
#import <QZZToolsKit/QZZProgressHUD.h>
#import <QZZToolsKit/QZZSingleton.h>
#import <QZZToolsKit/QZZVerificationTools.h>
#import <QZZToolsKit/QZZWebImage.h>
#import <QZZToolsKit/QZZHelper.h>
#import <QZZToolsKit/QZZDBManager.h>

#import <QZZFunctionalComponentsKit/UITableView+XSAnimationKit.h>
#import <QZZFunctionalComponentsKit/TableViewAnimationKitHeaders.h>
#import <QZZFunctionalComponentsKit/QZZRefresh.h>


#import <QZZMainViewKit/UITableViewCell+QZZAdd.h>
#import <QZZMainViewKit/QZZNavigationController.h>
#import <QZZMainViewKit/QZZViewController.h>

#import <QZZMainViewKit/QZZAlertView.h>
#import <QZZMainViewKit/DatePickerView.h>
#import <QZZMainViewKit/GotoOtherViewCell.h>
#import <QZZMainViewKit/KuanTextViewAllDataCell.h>
#import <QZZMainViewKit/KuanTextViewTableViewCell.h>
#import <QZZMainViewKit/MoreSelectedSearchOptionsListView.h>
#import <QZZMainViewKit/OptionsListView.h>
#import <QZZMainViewKit/SearchOptionsListView.h>
#import <QZZMainViewKit/ScrollOptionsView.h>
#import <QZZMainViewKit/SelectedTableViewCell.h>
#import <QZZMainViewKit/TextTableViewCell.h>
#import <QZZMainViewKit/GongNengOptionsView.h>











