//
//  ChatInfoModel.m
//  
//
//  Created by 秦忠增 on 2018/7/25.
//

#import "ChatInfoModel.h"

@implementation ChatInfoModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
