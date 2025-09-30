//
//  MHTRunTimeEnvironment.h
//  MHTRunTimeEnvironment
//
//  Created by mangox on 2025/9/24.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface MHTRunTimeEnvironment : NSObject
/// Singleton
+ (instancetype)sharedInstance;

/// 接口
@property (nonatomic,copy, readonly) NSString *proxyURL;
/// 资源
@property (nonatomic,copy, readonly) NSString *resourceURL;
/// 资源防盗链，仅release环境使用
@property (nonatomic,copy, readonly) NSString *nimgURL;
/// 头像资源
@property (nonatomic,copy, readonly) NSString *avatarURL;
/// 静态配置
@property (nonatomic,copy, readonly) NSString *xossimgURL;
/// 语音房socket
@property (nonatomic,copy, readonly) NSString *voiceSocketURL;
/// 视频房socket
@property (nonatomic,copy, readonly) NSString *videoSocketURL;
/// IM socket
@property (nonatomic,copy, readonly) NSString *imSocketURL;
/// 游戏socket
@property (nonatomic,copy, readonly) NSString *gameSocketURL;
/// 水果socket
@property (nonatomic,copy, readonly) NSString *fruitGameSocketURL;
/// 落地页
@property (nonatomic,copy, readonly) NSString *webURL;
/// 游戏活动
@property (nonatomic,copy, readonly) NSString *h5URL;
/// 应用ID
@property (nonatomic,copy, readonly) NSString *appId;
/// 渠道pid
@property (nonatomic,copy, readonly) NSString *pid;
/// 渠道sid
@property (nonatomic,copy, readonly) NSString *sid;
@end

NS_ASSUME_NONNULL_END
