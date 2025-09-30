//
//  MHTPublicParameters.m
//  MHTPublicParameters
//
//  Created by mangox on 2025/9/24.
//

#import "MHTPublicParameters.h"
#import "UIDevice+MHTDeviceInfo.h"
#import <MHTRunTimeEnvironment/MHTRunTimeEnvironment.h>
#import "AFNetworking.h"

NSString *const kAuthTime = @"/proxy/auth/time";
static long long _timeDifference = 0;

@implementation MHTPublicParameters
/// 公参获取
+ (NSDictionary *)publicParameters {
    NSString *imei = [UIDevice mht_imei];
    NSDictionary *common = @{
                            @"imei":imei,
                            @"deviceId":imei,
                            @"pid":[MHTRunTimeEnvironment sharedInstance].pid,
                            @"sid":[MHTRunTimeEnvironment sharedInstance].sid,
                            @"appId":[MHTRunTimeEnvironment sharedInstance].appId,
                            @"appVersion":[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                            @"sysVersion":[UIDevice currentDevice].systemVersion,
                            @"loginId": @"",
                            @"signalType":@"",
                            @"ts":[self ts],
                            @"lp":@"",
                            @"lc":@""
                            };
    return common;
}

+ (void)syncTime {
    NSString *url = [NSString stringWithFormat:@"%@%@", [MHTRunTimeEnvironment sharedInstance].proxyURL, kAuthTime];
    [[AFHTTPSessionManager manager] GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *ts = responseObject[@"result"][@"ts"];
        long long serverts = [ts longLongValue];
        if (serverts != 0) {
            _timeDifference = serverts - ([[NSDate date] timeIntervalSince1970] * 1000);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}

/// 校时后的当前13位时间戳
+ (NSString *)ts {
    long long current = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *ts = [NSString stringWithFormat:@"%lld",(_timeDifference + current)];
    return ts;
}
@end
