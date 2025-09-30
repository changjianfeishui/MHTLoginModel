//
//  MHTRefreshTokenUpdater.m
//  MHTLoginModel
//
//  Created by mangox on 2025/9/26.
//

#import "MHTRefreshTokenUpdater.h"
#import <MHTRunTimeEnvironment/MHTRunTimeEnvironment.h>

#define kRefreshToken @"/auth/token/refresh?"

@implementation MHTRefreshTokenUpdater
- (void)refreshTokenWithParams:(NSDictionary *)params completion:(void (^)(NSDictionary *loginResponse,NSError *error))completion {
    NSString *URLString = [self logRequestUrlWithAction:kRefreshToken andParams:params];
    NSData *data = [self synchronousRequestWithURL:[NSURL URLWithString:URLString]];
    if (!data) {
        NSError *error = [NSError errorWithDomain:NSStringFromClass(self.class) code:920002 userInfo:@{NSLocalizedDescriptionKey:@"登录已过期"}];
        completion(nil,error);
        return;
    }
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if ((!resultDic)||([resultDic[@"status"] integerValue] != 1)) {
        int errorCode = [[resultDic objectForKey:@"errorCode"] intValue] ?:0;
        NSError *error;
        switch (errorCode) {
            case 551018:
            case 551019:
            case 551020:
            case 551021:
                error = [NSError errorWithDomain:NSStringFromClass(self.class) code:errorCode userInfo:@{NSLocalizedDescriptionKey:@"登录已过期"}];
                break;
            case 552011:
                error = [NSError errorWithDomain:NSStringFromClass(self.class) code:552011 userInfo:@{NSLocalizedDescriptionKey:@"该账号已被封"}];
                break;
            default:
                error = [NSError errorWithDomain:NSStringFromClass(self.class) code:920002 userInfo:@{NSLocalizedDescriptionKey:@"登录已过期"}];
                break;
        }
        completion(nil,error);
        return;
    }
    completion(resultDic,nil);
}

- (NSData *)synchronousRequestWithURL:(NSURL *)url {
    __block NSData *data = nil;
    // 创建一个信号量，初始值为 0
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 5; // 设置超时时间（秒）
    // 创建一个 URLSession 任务
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable receivedData, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"请求出错: %@", error.localizedDescription);
        } else {
            data = receivedData;
        }
        // 发送信号，唤醒等待的线程
        dispatch_semaphore_signal(semaphore);
    }];
    
    // 启动任务
    [task resume];
    
    // 等待信号量，阻塞当前线程
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    return data;
}

- (NSString *)logRequestUrlWithAction:(NSString *)action andParams:(NSDictionary *)params {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",[MHTRunTimeEnvironment sharedInstance].proxyURL, action];
    NSArray *allkeys = [params allKeys];
    NSMutableString *paramsString = [NSMutableString string];
    for (int i=0; i<allkeys.count; i++) {
        NSString *key = [allkeys objectAtIndex:i];
        NSString *value = [params objectForKey:key];
        if (i == allkeys.count-1) {
            [paramsString appendFormat:@"%@=%@",key,value];
        }else{
            [paramsString appendFormat:@"%@=%@&",key,value];
        }
    }
    
    if (paramsString.length > 0) {
        urlStr = [urlStr stringByAppendingString:paramsString];
    }
    return [urlStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2b"];
}
@end
