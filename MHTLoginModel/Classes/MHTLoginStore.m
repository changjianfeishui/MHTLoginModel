//
//  MHTLoginStore.m
//  MHTLoginModel
//
//  Created by mangox on 2025/9/25.
//

#import "MHTLoginStore.h"

#define MHTLoginInfoFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MHTLoginInfo.data"]


@implementation MHTLoginStore
/**
 *  持久化认证
 */
+ (BOOL)save:(MHTLoginInfo *)Info {
    return [NSKeyedArchiver archiveRootObject:Info toFile:MHTLoginInfoFile];
}

/**
 *  读取认证
 */
+ (MHTLoginInfo *)fetch {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:MHTLoginInfoFile];
}

/**
 *  删除认证
 */
+ (BOOL)remove {
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    BOOL isExist = [fileMgr fileExistsAtPath:MHTLoginInfoFile];
    if (isExist) {
        return [fileMgr removeItemAtPath:MHTLoginInfoFile error:nil];
    }
    return YES;
}
@end
