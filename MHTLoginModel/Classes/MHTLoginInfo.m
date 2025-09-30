//
//  MHTLoginInfo.m
//  MHTLoginModel
//
//  Created by mangox on 2025/9/25.
//

#import "MHTLoginInfo.h"
#import "YYModel.h"

@implementation MHTLoginInfo
/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
/**
 *  从文件中解析对象的时候调
 */
- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}

- (NSString *)openId {
    NSString *token = self.token;
    NSArray *arr = [token componentsSeparatedByString:@"."];
    if (arr.count > 1) {
        return arr[1];
    }
    return @"";
}

@end
