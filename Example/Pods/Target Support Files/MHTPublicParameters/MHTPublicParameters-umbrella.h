#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HSKeychainQuery.h"
#import "HSSSKeychain.h"
#import "MHTPublicParameters.h"
#import "UIDevice+MHTDeviceInfo.h"

FOUNDATION_EXPORT double MHTPublicParametersVersionNumber;
FOUNDATION_EXPORT const unsigned char MHTPublicParametersVersionString[];

