//
//  MHTLoginModel.m
//  AFNetworking
//
//  Created by mangox on 2025/9/25.
//

#import "MHTLoginModel.h"
#import "MHTLoginStore.h"
#import <MHTRunTimeEnvironment/MHTRunTimeEnvironment.h>
#import <MHTHTTPService/MHTHTTPService.h>
#import "SVProgressHUD.h"
#import "YYModel.h"
#import <MHTPublicParameters/MHTPublicParameters.h>
#import "UIDevice+MHTDeviceInfo.h"
#import "MHTRefreshTokenUpdater.h"
#import <MHTUserModelInterface/MHTRouter+UserModel.h>

@interface MHTLoginModel ()

/// 登录信息
@property (nonatomic, strong, readwrite) MHTLoginInfo *loginInfo;
/// 上次刷新token时间
@property (nonatomic,assign) long long lastRefreshTimestamp;
@property (nonatomic,strong) MHTRefreshTokenUpdater *refreshService;

@end

@implementation MHTLoginModel

+ (instancetype)sharedInstance {
    static MHTLoginModel *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_instance) {
            _instance = [[MHTLoginModel alloc] init];
        }
    });
    return _instance;
}

/**
 退出登录
 */
- (void)invalidLoginWithError:(nullable NSError *)error {
    // TODO: MGX 通知外部退出登录
    if (!self.currentLoginStatus) {
        return;
    }
    [MHTLoginStore remove];
    self.loginInfo = nil;
}


/// 登录
/// - Parameters:
///   - token: 用户令牌
///   - uid: 用户标识
///   - expired: 过期时间
- (void)loginWithCredentialToken:(NSString *)token completion:(void(^)(MHTUserInfo *userInfo,NSError *error))completion {
    NSString *url = [[MHTRunTimeEnvironment sharedInstance].proxyURL stringByAppendingString:@"/auth/login/token"];
    NSDictionary *parama= @{
                           @"fromType":@"19",
                           @"code":token,
                           };
    __weak typeof (self) ws = self;

    [MHTHTTPService POST:url authType:MHTAuthTypeSafe parameters:parama completion:^(id  _Nonnull httpResponse, NSError * _Nonnull error) {
        if (error) {
            NSInteger errorCode = error.code;
            // TODO: MGX 通知外部错误处理
            if (errorCode == 552011) {
                error = [ws handle552011:httpResponse error:error];
            }
            completion(nil, error);
            return;
        }
        
        [ws handleLoginSuccess:httpResponse];
        
        [MHTRouter router_requestUserInfo:^(MHTUserInfo * _Nonnull userInfo, NSError * _Nonnull error) {
            if (error) {
                // TODO: MGX 通知外部错误处理
                completion(nil, error);
            } else {
                // TODO: MGX 通知外部登录成功
                completion(userInfo, nil);
            }
        }];
        
    }];
    
}

- (void)handleLoginSuccess:(NSDictionary *)result {
    // TODO: MGX 通知外部登录成功
    //自动刷新token后 loginId不会改变，需要手动记录
    NSDictionary * map = result[@"result"]?result[@"result"]:result;
    NSString *loginId = map[@"loginId"]?:self.loginInfo.loginId;
    self.loginInfo = [MHTLoginInfo yy_modelWithDictionary:map];
    
    NSString *expire = [NSString stringWithFormat:@"%d",[map[@"expire"] intValue]];
    long long time = [MHTPublicParameters ts].longLongValue + expire.longLongValue * 1000;
    NSString *expireString = [NSString stringWithFormat:@"%lld",time];
    self.loginInfo.expire = expireString;
    self.loginInfo.loginId = (loginId == nil?self.loginInfo.loginId:loginId);
    [MHTLoginStore save:self.loginInfo];
    
}

/// 处理账号被封的情况
- (NSError *)handle552011:(NSDictionary *)httpResponse error:(NSError *)error {
    long long resultTime = [httpResponse[@"errorMsg"] longLongValue];
    NSString *errorMsg;
    if (resultTime == 4070880000000) {
        errorMsg = @"该账号已被永久封禁";
    }else{
        long long targetTime = resultTime/1000;
        NSInteger currentTime = [[NSDate date] timeIntervalSince1970];
        long long subTime = targetTime - currentTime;
        NSInteger hours = subTime/3600;
        NSInteger days = hours/24;
        hours = hours - days * 24;
        errorMsg = [NSString stringWithFormat:@"该账号已被封禁,剩余时间%ld天%ld小时",days,hours];
    }
    return [NSError errorWithDomain:NSStringFromClass(self.class) code:error.code userInfo:@{NSLocalizedDescriptionKey:errorMsg}];
}

/// 刷新token
- (void)tryRefreshToken {
    if (!self.loginInfo) {
        NSError *error = [NSError errorWithDomain:NSStringFromClass(self.class) code:920003 userInfo:@{NSLocalizedDescriptionKey:@"登录已过期"}];
        [self invalidLoginWithError:error];
        return;
    }
    long long currentTimestamp = [[NSDate date] timeIntervalSince1970]*1000;
    if (currentTimestamp -  self.lastRefreshTimestamp < 10 * 1000) {
        return;
    }else{
        self.lastRefreshTimestamp = currentTimestamp;
    }
    NSDictionary *tempPara = @{@"refreshToken":self.loginInfo.refreshToken?:@"",
                               @"appId":[MHTRunTimeEnvironment sharedInstance].appId,
                               @"deviceId":[UIDevice mht_imei]
                               };
    NSDictionary *encodeParam = [MHTAuthModel authWithType:MHTAuthTypeSafe parameters:tempPara rc4Required:YES];
    NSString *data = encodeParam[@"data"];
    
    NSMutableDictionary *safeVerified = [NSMutableDictionary dictionaryWithDictionary:encodeParam];
    safeVerified[@"data"] = [MHTAuthModel urlEncode:data];
    __weak typeof(self) weakSelf = self;
     self.refreshService = [[MHTRefreshTokenUpdater alloc]init];
    [self.refreshService refreshTokenWithParams:safeVerified completion:^(NSDictionary *loginResponse, NSError *error) {
        if (error) {
            [weakSelf invalidLoginWithError:error];
        }else{
            [weakSelf handleLoginSuccess:loginResponse];
        }
    }];
}

@end
