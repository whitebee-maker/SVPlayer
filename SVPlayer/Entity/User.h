//
//  User.h
//  SVPlayer
//
//  Created by xk on 2025/2/6.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User : BaseModel

@property(nonatomic, copy) NSString         *uid;
@property(nonatomic, copy) NSString         *nickname;
@property(nonatomic, assign) NSInteger      follower_count;
@property(nonatomic, assign) NSInteger      following_count;
@property(nonatomic, assign) NSInteger      aweme_count;
@property(nonatomic, assign) NSInteger      favourite_count;
@property(nonatomic , copy) NSString        *avatar_url;


@end

NS_ASSUME_NONNULL_END
