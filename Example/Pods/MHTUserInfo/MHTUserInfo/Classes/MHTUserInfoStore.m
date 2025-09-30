//
//  MHTUserInfoStore.m
//  MHTUserInfo
//
//  Created by mangox on 2025/9/28.
//

#import "MHTUserInfoStore.h"

#define MHTUserInfoFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"user.data"]


@implementation MHTUserInfoStore
/**
 *  持久化认证
 */
+ (BOOL)save:(MHTUserInfo *)Info {
    NSError *error;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:Info requiringSecureCoding:NO error:&error];
    return [data writeToFile:MHTUserInfoFile atomically:YES];
}
/**
 *  读取认证
 */
+ (nullable MHTUserInfo *)fetch {
    NSData *data = [NSData dataWithContentsOfFile:MHTUserInfoFile];
    NSError *error;
    MHTUserInfo *info = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithArray:@[MHTUserInfo.class, NSString.class, NSNumber.class]] fromData:data error:&error];
    return info;
}
/**
 *  删除认证
 */
+ (void)remove {
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    BOOL isExist = [fileMgr fileExistsAtPath:MHTUserInfoFile];
    if (isExist) {
        [fileMgr removeItemAtPath:MHTUserInfoFile error:nil];
    }
}
@end
