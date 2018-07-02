//
//  TableViewCellModel.m
//  CRMNEW
//
//  Created by qinzhongzeng on 16/7/29.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import "TableViewCellModel.h"

@implementation TableViewCellModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

+ (instancetype)createWithTitle:(NSString *)title place:(NSString *)place infoDeatil:(NSString *)infoDetail Value:(NSString *)Value
{
    TableViewCellModel *model = [[TableViewCellModel alloc]init];
    model.lableTitle = title;
    model.placeHoled = place;
    model.info = infoDetail;
    model.Value = Value;
    return model;
}

@end
