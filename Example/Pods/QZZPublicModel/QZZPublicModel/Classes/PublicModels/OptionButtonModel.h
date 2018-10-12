//
//  OptionButtonModel.h
//  
//
//  Created by qinzhongzeng on 16/7/27.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionButtonModel : NSObject
///标题
@property (nonatomic, copy) NSString *optionBtnLabel;
///图片名
@property (nonatomic, copy) NSString *optionBtnImageName;
///选中时的图片名
@property (nonatomic, copy) NSString *optionBtnSelectedImageName;
///选项ID
@property (nonatomic, copy) NSString *optionValue;
///ID
@property (nonatomic, strong) NSNumber *Id;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
