//
//  MHTRouter+UserModel.h
//  MHTUserModelInterface
//
//  Created by mangox on 2025/9/28.
//

#import <MHTRouter/MHTRouter.h>
#import <MHTUserInfo/MHTUserInfo.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHTRouter (UserModel)
/// 获取用户信息
+ (MHTUserInfo *)router_getUserInfo;

/// 是否是当前用户
+ (BOOL)router_isSelf:(NSString *)targetUserId;

/// 更新本地用户信息, 传入nil表明移除本地用户信息
+ (void)router_updateUserInfo:(nullable MHTUserInfo *)userInfo;

/// 获取服务器最新用户信息
+ (void)router_requestUserInfo:(nullable void(^)(MHTUserInfo *userInfo,NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
