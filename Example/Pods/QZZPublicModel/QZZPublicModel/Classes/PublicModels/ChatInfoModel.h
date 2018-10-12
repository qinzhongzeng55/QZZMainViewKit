//
//  ChatInfoModel.h
//  
//
//  Created by 秦忠增 on 2018/7/25.
//

#import <Foundation/Foundation.h>

@interface ChatInfoModel : NSObject

@property (nonatomic, copy) NSString *chatContent;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
