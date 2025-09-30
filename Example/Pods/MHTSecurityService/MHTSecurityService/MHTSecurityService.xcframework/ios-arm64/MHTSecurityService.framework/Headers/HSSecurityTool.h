//
//  HSSecurityTool.h
//  GBEncodeTool
//
//  Created by mangox on 2023/4/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSSecurityTool : NSObject
/// 根据传入type类型，将NSDictionary的key值进行排序后转换成字符串输出
/// - Parameters:
///   - aDictionary: key必须为字符串类型
///   - type: 排序方式
+ (NSString *)stringWithDictionary:(NSDictionary *)aDictionary comparisontype:(NSComparisonResult)type;


/// 生成指定长度的随机字符串，包含大小写字母及数字
/// - Parameter length: 字符串长度
+ (NSString *)randomStringWithLength:(NSInteger)length;
@end

NS_ASSUME_NONNULL_END
