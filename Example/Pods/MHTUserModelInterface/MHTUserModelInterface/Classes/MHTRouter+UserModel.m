//
//  MHTRouter+UserModel.m
//  MHTUserModelInterface
//
//  Created by mangox on 2025/9/28.
//

#import "MHTRouter+UserModel.h"

NSString *const kMHTUserModelTarget = @"MHTUserModelTarget";
NSString *const kMHTGetUserInfo = @"action_getUserInfo";
NSString *const kMHTGetUserIsSelf = @"action_isSelf:";
NSString *const kMHTUpdateUserInfo = @"action_updateUserInfo:";
NSString *const kMHTRequestUserInfo = @"action_requestUserInfo:";

@implementation MHTRouter (UserModel)
/// 获取用户信息
+ (MHTUserInfo *)router_getUserInfo {
    return [self performTarget:kMHTUserModelTarget action:kMHTGetUserInfo params:nil];
}


/// 是否是当前用户
+ (BOOL)router_isSelf:(NSString *)targetUserId {
    return [[self performTarget:kMHTUserModelTarget action:kMHTGetUserIsSelf params:@{@"targetUserId":targetUserId?:@""}] boolValue];
}

/// 更新本地用户信息, 传入nil表明移除本地用户信息
+ (void)router_updateUserInfo:(nullable MHTUserInfo *)userInfo {
    NSDictionary *params = nil;
    if(userInfo) {
        params = @{@"userInfo":userInfo};
    }
    [self performTarget:kMHTUserModelTarget action:kMHTUpdateUserInfo params:params];
}

/// 获取服务器最新用户信息
+ (void)router_requestUserInfo:(nullable void(^)(MHTUserInfo *userInfo,NSError *error))completion {
    NSDictionary *params = nil;
    if(completion) {
        params = @{@"callback":completion};
    }
    [self performTarget:kMHTUserModelTarget action:kMHTRequestUserInfo params:params];
}
@end
