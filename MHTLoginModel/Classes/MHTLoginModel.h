//
//  MHTLoginModel.h
//  AFNetworking
//
//  Created by mangox on 2025/9/25.
//

#import <Foundation/Foundation.h>
#import "MHTLoginInfo.h"
#import <MHTUserInfo/MHTUserInfo.h>
NS_ASSUME_NONNULL_BEGIN

@interface MHTLoginModel : NSObject

/// Singleton
+ (instancetype)sharedInstance;

/**
 当前登录状态
 */
@property (nonatomic,assign,readonly) BOOL currentLoginStatus;

/// 登录信息
@property (nonatomic, strong, readonly) MHTLoginInfo *loginInfo;

/**
 退出登录
 */
- (void)invalidLoginWithError:(nullable NSError *)error;


/// 登录
/// - Parameters:
///   - token: 用户唯一标识
- (void)loginWithCredentialToken:(NSString *)token completion:(void(^)(MHTUserInfo * _Nullable userInfo,NSError * _Nullable error))completion;


/// 刷新token
- (void)tryRefreshToken;
@end

NS_ASSUME_NONNULL_END
