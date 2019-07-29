//
//  TableViewCellModel.h
//  
//
//  Created by qinzhongzeng on 16/7/29.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCellModel : NSObject
///标题
@property (copy,nonatomic) NSString *lableTitle;
///占位文字
@property (copy, nonatomic) NSString *placeholder;
///内容
@property (copy,nonatomic) NSString *info;
///info若是选项的话,Value表示选项对应的ID
@property (copy, nonatomic) NSString *Value;
///属性名
@property (nonatomic, copy) NSString *paramName;
///id
@property (nonatomic, strong) NSNumber *Id;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)createWithTitle:(NSString*)title place:(NSString*)place infoDeatil:(NSString*)infoDetail Value:(NSString *)Value;
@end
