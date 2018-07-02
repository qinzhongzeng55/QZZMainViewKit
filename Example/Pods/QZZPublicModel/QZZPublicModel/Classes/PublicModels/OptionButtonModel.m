//
//  OptionButtonModel.m
//  
//
//  Created by qinzhongzeng on 16/7/27.
//  Copyright © 2016年 bejingyimeng. All rights reserved.
//

#import "OptionButtonModel.h"

@implementation OptionButtonModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
