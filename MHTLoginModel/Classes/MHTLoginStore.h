//
//  MHTLoginStore.h
//  MHTLoginModel
//
//  Created by mangox on 2025/9/25.
//

#import <Foundation/Foundation.h>
#import "MHTLoginInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHTLoginStore : NSObject
/**
 *  持久化认证
 */
+ (BOOL)save:(MHTLoginInfo *)Info;
/**
 *  读取认证
 */
+ (nullable MHTLoginInfo *)fetch;
/**
 *  删除认证
 */
+ (BOOL)remove;
@end

NS_ASSUME_NONNULL_END
