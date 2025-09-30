//
//  MHTAuthModel.h
//  MHTAuthModel
//
//  Created by mangox on 2025/9/24.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MHTAuthType) {
    MHTAuthTypeNone,      //无认证
    MHTAuthTypeLogin,     //登录认证
    MHTAuthTypeSign,      //签名认证
    MHTAuthTypeSafe,      //安全认证
    MHTAuthTypeLoginSafe, //登录+安全认证
};

NS_ASSUME_NONNULL_BEGIN

@interface MHTAuthModel : NSObject

/// 参数加密
/// - Parameters:
///   - authType: 加密类型
///   - parameters: 加密参数
///   - isRC4Required: 加密结果是否需要RC4二次加密
+ (NSDictionary *)authWithType:(MHTAuthType)authType parameters:(NSDictionary *)parameters rc4Required:(BOOL)isRC4Required;

/// 字符串url编码
+ (NSString *)urlEncode:(NSString *)aString;
@end

NS_ASSUME_NONNULL_END
