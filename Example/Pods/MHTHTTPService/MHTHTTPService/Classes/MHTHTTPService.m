//
//  MHTHTTPService.m
//  AFNetworking
//
//  Created by mangox on 2025/9/25.
//

#import "MHTHTTPService.h"
#import "AFNetworking.h"
#import <MHTPublicParameters/MHTPublicParameters.h>
#import <MHTLoginModelInterface/MHTRouter+LoginModel.h>
#import <MHTAuthModel/MHTAuthModel.h>
@interface MHTHTTPService ()
@property (nonatomic, strong, readonly, class) AFHTTPSessionManager *sessionManger;
@end

static AFHTTPSessionManager *_sessionManger;

@implementation MHTHTTPService

#pragma mark Public

+ (void)GET:(NSString *)URLString authType:(MHTAuthType)authType parameters:(NSDictionary *)parameters completion:(void(^)(id httpResponse, NSError *error))completion {
    if (![self tokenEnable:authType]) {
        return;
    }
    NSDictionary *finalParams = [MHTAuthModel authWithType:authType parameters:parameters rc4Required:YES];
    [self GET:URLString parameters:finalParams completion:^(id httpResponse, NSError *error) {
        [self handleResponse:httpResponse url:URLString error:error completion:completion];
    }];
}

+ (void)POST:(NSString *)URLString authType:(MHTAuthType)authType parameters:(NSDictionary *)parameters completion:(void(^)(id httpResponse, NSError *error))completion {
    if (![self tokenEnable:authType]) {
        return;
    }
    NSDictionary *finalParams = [MHTAuthModel authWithType:authType parameters:parameters rc4Required:YES];
    [self POST:URLString parameters:finalParams completion:^(id httpResponse, NSError *error) {
        [self handleResponse:httpResponse url:URLString error:error completion:completion];
    }];
}

+ (void)cancelAllOperation {
    [self.sessionManger.operationQueue cancelAllOperations];
}

#pragma mark Private

+ (BOOL)tokenEnable:(MHTAuthType)encryptType {
    if (encryptType == MHTAuthTypeLogin || encryptType == MHTAuthTypeLoginSafe) {
        if ([MHTRouter router_getToken].length == 0) {
            return NO;
        }
    }
    return YES;
}

+ (void)handleResponse:(id)httpResponse url:(NSString *)url error:(NSError *)error completion:(void(^)(id httpResponse, NSError *error))completion {
    if (error) {
        completion(nil, error);
        return;
    }
    // 1. 如果包含refreshToken相关错误，则不继续处理
    if ([self isRefreshTokenCode:httpResponse]) {
        return;
    }
    // 2. 检查是否包含其他业务错误码
    error = [self checkHTTPResponse:httpResponse];
    // 解包result
    completion(httpResponse[@"result"] ?: httpResponse,error);
}

+ (NSError *)checkHTTPResponse:(NSDictionary *)httpResponse {
    NSInteger status = [httpResponse[@"status"] integerValue];
    if (status == 1) {
        return nil;
    }
    NSInteger errCode = [httpResponse[@"errorCode"] integerValue];
    if (errCode == 0) {
        return nil;
    }
    if ([self isTokenErrorCode:errCode]) {
        //刷新token
        [MHTRouter router_tryRefreshToken];
        return nil;
    }
    NSString *errorMsg = httpResponse[@"errorMsg"]?:@"";
    NSError *error = [NSError errorWithDomain:NSStringFromClass(self.class) code:errCode  userInfo:@{NSLocalizedDescriptionKey:errorMsg}];
    return error;
}

/// 检查HTTP返回结果是否包含RefreshToken相关错误
+ (BOOL)isRefreshTokenCode:(NSDictionary *)httpResponse {
    if ([httpResponse[@"status"] integerValue] == 1) {
        return NO;
    }
    NSInteger errCode = [httpResponse[@"errorCode"] integerValue];
    for(int j = 0; j < self.refreshTokenErrorCodes.count;j++){
        if (errCode == [self.refreshTokenErrorCodes[j] integerValue]) {
            NSString *errorMsg = httpResponse[@"errorMsg"]?:@"";
            NSError *error = [NSError errorWithDomain:NSStringFromClass(self.class) code:errCode  userInfo:@{NSLocalizedDescriptionKey:errorMsg}];
            [MHTRouter router_invalidLoginWithError:error];
            // TODO: MGX 通知外部app登录失效
            return YES;
        }
    }
    return NO;
}

/// 判断入参是否为token相关错误码
+ (BOOL)isTokenErrorCode:(NSInteger)errorCode {
    // 551007: token非法
    // 551008: token失效
    NSArray *tokenErrorCodes = @[@(551007), @(551008)];
    for(int j = 0; j < tokenErrorCodes.count; j++) {
        if (errorCode == [tokenErrorCodes[j] integerValue]) {
            return YES;
        }
    }
    return NO;
}

+ (NSArray *)refreshTokenErrorCodes {
    return @[
             @(551018), //refreshToken非法
             @(551019), //refreshToken失效。
             @(551020), //refreshToken失效
             @(551021)  //多端重复登录
             ];
}

#pragma mark AFNetworking

+ (void)GET:(NSString *)URLString parameters:(id)parameters completion:(void(^)(id httpResponse, NSError *error))completion {
    [self.sessionManger GET:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        if ([responseObject isKindOfClass:[NSData class]]) {
            responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        }
        if (responseObject) {
            completion(responseObject,nil);
        }else{
            completion(nil,error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil,error);
    }];
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters completion:(void(^)(id httpResponse, NSError *error))completion {
    [self.sessionManger POST:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        if ([responseObject isKindOfClass:[NSData class]]) {
            responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        }
        if (responseObject) {
            completion(responseObject,nil);
        }else{
            completion(nil,error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil,error);
    }];
}


+ (AFHTTPSessionManager *)sessionManger {
    if (!_sessionManger) {
        _sessionManger = [AFHTTPSessionManager manager];
        _sessionManger.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sessionManger.requestSerializer.HTTPShouldHandleCookies = NO;
        _sessionManger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/html", @"text/javascript",@"text/plain",@"application/octet-stream", nil];
        //网络请求时间
        [_sessionManger.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _sessionManger.requestSerializer.timeoutInterval = 10;
        [_sessionManger.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    return _sessionManger;
}
@end
