//
//  UserInfoHeader.h
//  SVPlayer
//
//  Created by weibin on 2025/1/20.
//

#import <UIKit/UIKit.h>

static const NSInteger UserInfoHeaderAvatarTag = 0x01;

NS_ASSUME_NONNULL_BEGIN

@protocol UserInfoHeaderDelegate

- (void)onUserInfoHeaderActionTap:(NSInteger)tag;

@end


@interface UserInfoHeader : UICollectionReusableView

@property(nonatomic, weak) id<UserInfoHeaderDelegate> delegate;

- (void)verticalScrollAction:(CGFloat) offsetY;

@end

NS_ASSUME_NONNULL_END
