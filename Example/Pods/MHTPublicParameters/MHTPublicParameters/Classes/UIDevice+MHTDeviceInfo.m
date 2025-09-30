//
//  UIDevice+MHTDeviceInfo.m
//  MHTPublicParameters
//
//  Created by mangox on 2025/9/24.
//

#import "UIDevice+MHTDeviceInfo.h"
#import "HSSSKeychain.h"

@implementation UIDevice (MHTDeviceInfo)

+ (NSString *)mht_imei {
    NSString * currentDeviceUUIDStr = [HSSSKeychain passwordForService:@"com-wobo-live"account:@"uuid"];
    if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""]) {
        NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
        currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
        [HSSSKeychain setPassword: currentDeviceUUIDStr forService:@"com-wobo-live"account:@"uuid"];
    }
    return currentDeviceUUIDStr;
}
@end
