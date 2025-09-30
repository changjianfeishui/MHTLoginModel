//
//  MHTHTTPService.h
//  AFNetworking
//
//  Created by mangox on 2025/9/25.
//

#import <Foundation/Foundation.h>
#import <MHTAuthModel/MHTAuthModel.h>


NS_ASSUME_NONNULL_BEGIN

@interface MHTHTTPService : NSObject

+ (void)GET:(NSString *)URLString authType:(MHTAuthType)authType parameters:(nullable NSDictionary *)parameters completion:(void(^)(id _Nullable httpResponse, NSError * _Nullable error))completion;

+ (void)POST:(NSString *)URLString authType:(MHTAuthType)authType parameters:(NSDictionary *)parameters
  completion:(void(^)(id _Nullable httpResponse,  NSError * _Nullable error))completion;


/// 取消操作队列中所有尚未执行的操作
+ (void)cancelAllOperation;
@end

NS_ASSUME_NONNULL_END
