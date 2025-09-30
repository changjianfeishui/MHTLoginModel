//
//  MHTLoginInfo.h
//  MHTLoginModel
//
//  Created by mangox on 2025/9/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHTLoginInfo : NSObject
/**
 短期令牌
 */
@property (nonatomic,copy) NSString *token;

/**
 过期时间
 */
@property (nonatomic,copy) NSString *expire;

/**
 长期令牌,时间由服务端控制
 */
@property (nonatomic,copy) NSString *refreshToken;

/**
 本次登录标识码
 */
@property (nonatomic,copy) NSString *loginId;

/// openId
- (NSString *)openId;
@end

NS_ASSUME_NONNULL_END
