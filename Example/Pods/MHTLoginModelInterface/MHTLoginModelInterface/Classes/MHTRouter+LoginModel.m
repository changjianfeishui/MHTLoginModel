//
//  MHTRouter+LoginModel.m
//  AFNetworking
//
//  Created by mangox on 2025/9/25.
//

#import "MHTRouter+LoginModel.h"

NSString *const kMHTLoginServiceTarget = @"MHTLoginModelTarget";
NSString *const kMHTGetLoginStatus = @"action_getCurrentLoginStatus";
NSString *const kMHTGetLoginId = @"action_getLoginId";
NSString *const kMHTGetOpenId = @"action_getOpenId";
NSString *const kMHTGetToken = @"action_getToken";
NSString *const kMHTTryRefreshToken = @"action_tryRefreshToken";
NSString *const kMHTInvalidLogin = @"action_invalidLoginWithError:";


@implementation MHTRouter (LoginModel)
/// 获取当前登陆id
+ (NSString *)router_getLoginId {
    return [self performTarget:kMHTLoginServiceTarget action:kMHTGetLoginId params:nil];
}

/// 获取当前登陆状态
/// 游客身份同样视为登陆成功
+ (BOOL)router_getCurrentLoginStatus {
    return [[self performTarget:kMHTLoginServiceTarget action:kMHTGetLoginStatus params:nil] boolValue];
}

/// 获取当前登陆的openId
+ (NSString *)router_getOpenId {
    return [self performTarget:kMHTLoginServiceTarget action:kMHTGetOpenId params:nil];
}

/// 获取当前登陆的token
+ (NSString *)router_getToken {
    return [self performTarget:kMHTLoginServiceTarget action:kMHTGetToken params:nil];
}

/// 刷新token
+ (void)router_tryRefreshToken {
    [self performTarget:kMHTLoginServiceTarget action:kMHTTryRefreshToken params:nil];
}

/// 退出登录
+ (void)router_invalidLoginWithError:(nullable NSError *)error {
    [self performTarget:kMHTLoginServiceTarget action:kMHTInvalidLogin params:error? @{@"error":error} : nil];
}
@end
