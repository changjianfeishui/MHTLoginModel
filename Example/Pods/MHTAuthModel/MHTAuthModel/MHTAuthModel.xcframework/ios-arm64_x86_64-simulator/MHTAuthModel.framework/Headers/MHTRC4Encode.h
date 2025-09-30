//
//  Encode.h
//  Base64+rc4
//
//  Created by han on 2017/8/24.
//  Copyright © 2017年 han. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHTRC4Encode : NSObject
+ (NSString *)encode:(NSString *)data key:(NSString *)key;
+ (NSString *)decode:(NSString *)data key:(NSString *)key;

@end

