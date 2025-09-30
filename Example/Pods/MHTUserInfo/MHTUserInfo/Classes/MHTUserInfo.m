//
//  MHTUserInfo.m
//  MHTUserModel
//
//  Created by mangox on 2025/9/28.
//

#import "MHTUserInfo.h"
#import "YYModel.h"
@implementation MHTUserInfo
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (NSString *)amount {
    return _amount ?: @"0";
}

- (NSString *)contribute {
    return _contribute ?: @"0";
}
@end
