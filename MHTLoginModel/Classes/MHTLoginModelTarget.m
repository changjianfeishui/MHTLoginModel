//
//  MHTLoginModelTarget.m
//  MHTLoginModel
//
//  Created by mangox on 2025/9/25.
//

#import "MHTLoginModelTarget.h"
#import "MHTLoginModel.h"
@implementation MHTLoginModelTarget

/// 获取当前登陆状态
/// 游客身份同样视为登陆成功
+ (BOOL)action_getCurrentLoginStatus {
    return [MHTLoginModel sharedInstance].currentLoginStatus;
}

/// 获取当前登陆的LoginId
+ (NSString *)action_getLoginId {
    return [MHTLoginModel sharedInstance].loginInfo.loginId;
}

/// 获取当前登陆的openId
+ (NSString *)action_getOpenId {
    return [MHTLoginModel sharedInstance].loginInfo.loginId;
}

/// 获取当前登陆的token
+ (NSString *)action_getToken {
    return [MHTLoginModel sharedInstance].loginInfo.token;
}

/// 刷新token
+ (void)action_tryRefreshToken {
    [[MHTLoginModel sharedInstance] tryRefreshToken];
}

+ (void)action_invalidLoginWithError:(NSDictionary *)params {
    [[MHTLoginModel sharedInstance] invalidLoginWithError:params[@"error"]];
}
@end
