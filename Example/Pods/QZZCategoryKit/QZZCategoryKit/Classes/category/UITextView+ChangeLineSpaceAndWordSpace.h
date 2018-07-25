//
//  UITextView+ChangeLineSpaceAndWordSpace.h
//  Pods-QZZCategoryKit_Example
//
//  Created by 秦忠增 on 2018/7/25.
//

#import <UIKit/UIKit.h>

@interface UITextView (ChangeLineSpaceAndWordSpace)

/**
 *  改变行间距
 */
+ (void)changeLineSpace:(UITextView *)textView WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpace:(UITextView *)textView WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpace:(UITextView *)textView withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;
@end
