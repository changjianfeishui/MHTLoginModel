//
//  MHTRouter+LoginModel.h
//  AFNetworking
//
//  Created by mangox on 2025/9/25.
//

#import <MHTRouter/MHTRouter.h>
NS_ASSUME_NONNULL_BEGIN

@interface MHTRouter (LoginModel)
/// 获取当前登陆id
+ (NSString *)router_getLoginId;

/// 获取当前登陆状态
+ (BOOL)router_getCurrentLoginStatus;

/// 获取当前登陆的openId
+ (NSString *)router_getOpenId;

/// 获取当前登陆的token
+ (NSString *)router_getToken;

/// 刷新token
+ (void)router_tryRefreshToken;

/// 退出登录
+ (void)router_invalidLoginWithError:(nullable NSError *)error;
@end

NS_ASSUME_NONNULL_END
