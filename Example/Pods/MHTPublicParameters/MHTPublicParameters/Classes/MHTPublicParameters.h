//
//  MHTPublicParameters.h
//  MHTPublicParameters
//
//  Created by mangox on 2025/9/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHTPublicParameters : NSObject
/// 公参获取
+ (NSDictionary *)publicParameters;

/// 服务器时间同步
+ (void)syncTime;

/// 服务器同步后的时间戳
+ (NSString *)ts;
@end

NS_ASSUME_NONNULL_END
