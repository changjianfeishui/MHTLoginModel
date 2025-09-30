//
//  MHTRefreshTokenUpdater.h
//  MHTLoginModel
//
//  Created by mangox on 2025/9/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHTRefreshTokenUpdater : NSObject
- (void)refreshTokenWithParams:(NSDictionary *)params completion:(void (^)(NSDictionary *loginResponse,NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
