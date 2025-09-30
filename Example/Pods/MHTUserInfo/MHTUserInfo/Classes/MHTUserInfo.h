//
//  MHTUserInfo.h
//  MHTUserModel
//
//  Created by mangox on 2025/9/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHTUserInfo : NSObject
/**
 用户id
 */
@property (nonatomic,copy) NSString *userId;
/**
 头像
 */
@property (nonatomic,copy) NSString *avatar;
/**
 用户昵称
 */
@property (nonatomic,copy) NSString *nickName;
/**
 性别1=男，2=女，0=未知
 */
@property (nonatomic,copy) NSString *gender;
/**
 主播等级
 */
@property (nonatomic,copy) NSString *broadLevel;
/**
 财富等级
 */
@property (nonatomic,copy) NSString *level;
/**
 签名
 */
@property (nonatomic,copy) NSString *signInfo;
/**
 关注数量
 */
@property (nonatomic,copy) NSString *attentionCount;
/**
 粉丝数量
 */
@property (nonatomic,copy) NSString *fansCount;
/**
 当前经验
 */
@property (nonatomic,copy) NSString *exp;
/**
 升级还差经验
 */
@property (nonatomic,copy) NSString *upExp;
/**
 动态数量
 */
@property (nonatomic,copy) NSString *storyCount;

/**
 秀币数量
 */
@property (nonatomic,copy) NSString *amount;


/**
 是否主播，1=主播
 */
@property (nonatomic,copy) NSString *isBroad;
/**
 * 家族角色(0=无公会,1.族长 2.副族长 3.股东，4.星探 ,5.普通成员(含主播))
*/
@property (nonatomic, strong) NSNumber *familyRole;

/**
 糖果数量
 */
@property (nonatomic,strong) NSString *contribute;


/**
 0未充值用户 1充值用户
 */
@property (nonatomic,strong) NSString *isRecharge;

/**
 是否更新过头像：0未更新，1更新
 */
@property (nonatomic,strong) NSString *isUpdateAvatar;

/**
 贵族等级
 */
@property (nonatomic,strong) NSString *nobleLevel;

/**
 注册时间
 */
@property (nonatomic,strong) NSString *registTime;

/**
 0普通用户、1超管、6主播、9NPC、10游客,11客服，12神秘富豪
 */
@property (nonatomic,strong) NSString *role;

/**
 昵称颜色
 */
@property (nonatomic,copy) NSString *nickColor;

/**
 integer,1=新秀，2=新贵，0=无
 */
@property (nonatomic,copy) NSString *nobleMarkId;

/// 神秘富豪id
@property (nonatomic,strong) NSString *richId;

/// 公会id
@property (nonatomic, strong) NSString *broadFamilyId;

@end

NS_ASSUME_NONNULL_END
