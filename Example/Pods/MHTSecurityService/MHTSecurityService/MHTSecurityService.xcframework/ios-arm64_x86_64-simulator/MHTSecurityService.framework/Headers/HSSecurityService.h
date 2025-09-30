//
//  HSSecurityService.h
//  GBEncodeTool
//
//  Created by mangox on 2023/4/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSSecurityService : NSObject
/// RSA签名
/// - Return : 在入参的基础上增加sign字段后返回
+ (NSDictionary *)signParameters:(NSDictionary *)parameters;

/// 对传入的参数进行RSA+AES双重加密
/// - Return : {data:xxx, dataKey:xxx}形式
+ (NSDictionary *)safeEncodeParameters:(NSDictionary *)parameters;
@end

NS_ASSUME_NONNULL_END
