//
//  MHTUserInfoStore.h
//  MHTUserInfo
//
//  Created by mangox on 2025/9/28.
//

#import <Foundation/Foundation.h>
#import "MHTUserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHTUserInfoStore : NSObject
/**
 *  持久化认证
 */
+ (BOOL)save:(MHTUserInfo *)Info;
/**
 *  读取认证
 */
+ (nullable MHTUserInfo *)fetch;
/**
 *  删除认证
 */
+ (void)remove;
@end

NS_ASSUME_NONNULL_END
