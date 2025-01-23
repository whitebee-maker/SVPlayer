//
//  UserInfoHeader.m
//  SVPlayer
//
//  Created by weibin on 2025/1/20.
//

#import "UserInfoHeader.h"

#define TOP_BACKGROUND_HEIGHT      120.0

#define AVATAR_WITH                80.0
#define AVATAR_HEIGHT              80.0
#define AVATAR_Y                   (TOP_BACKGROUND_HEIGHT - (AVATAR_HEIGHT / 2))

@interface UserInfoHeader()

@property(nonatomic, strong) UIView *containerView;
@property(nonatomic, strong) UIImageView *topBackground;
@property(nonatomic, strong) UIImageView *bottomBackground;
@property(nonatomic, strong) UIImageView *avatarView;

@property(nonatomic, strong) UILabel *nickNameLabel;
@property(nonatomic, strong) UILabel *briefLabel;

@property(nonatomic, strong) UILabel *fansNumLabel;
@property(nonatomic, strong) UILabel *focusNumLabel;
@property(nonatomic, strong) UILabel *thumbNumLabel;

- (UILabel *)getSpliteLabel;

@end

@implementation UserInfoHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initWithSubViews];
    }
    return self;
}

- (void)initWithSubViews {
    [self initBackground];
    
    _containerView = [[UIView alloc] initWithFrame:self.bounds];
//    _containerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_containerView];

    [self initAvatar];
    [self iniLefttInfoView];
    [self initRightInfoView];
}

- (void)initBackground {
    _topBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, TOP_BACKGROUND_HEIGHT + SafeAreaTopHeight)];
    _topBackground.backgroundColor = [UIColor greenColor];
    _topBackground.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_topBackground];
    
    _bottomBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, TOP_BACKGROUND_HEIGHT + SafeAreaTopHeight, ScreenWidth, self.bounds.size.height - (TOP_BACKGROUND_HEIGHT + SafeAreaTopHeight))];
    _bottomBackground.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_bottomBackground];

    UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    visualEffectView.frame = _bottomBackground.bounds;
    visualEffectView.alpha = 1;
    [_bottomBackground addSubview:visualEffectView];
}

- (void)initAvatar {
    // 初始化头像
    _avatarView = [[UIImageView alloc] init];
    _avatarView.image = [UIImage imageNamed:@"img_find_default"];
    _avatarView.tag = UserInfoHeaderAvatarTag;
    _avatarView.userInteractionEnabled = YES;
    [_avatarView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAvatarTapAction:)]];
    _avatarView.translatesAutoresizingMaskIntoConstraints = NO; // 取消自动布局约束
    [_containerView addSubview:_avatarView];
    
    // 添加约束
    _avatarView.layer.cornerRadius = _avatarView.frame.size.width / 2;
    _avatarView.clipsToBounds = YES;
    [NSLayoutConstraint activateConstraints:@[
        [_avatarView.topAnchor constraintEqualToAnchor:_containerView.topAnchor constant:AVATAR_Y + SafeAreaTopHeight],
        [_avatarView.leadingAnchor constraintEqualToAnchor:_containerView.leadingAnchor constant:16],
        [_avatarView.widthAnchor constraintEqualToConstant:AVATAR_WITH], // 设置宽度
        [_avatarView.heightAnchor constraintEqualToConstant:AVATAR_HEIGHT] // 设置高度
    ]];
}

- (void)iniLefttInfoView {
    // 昵称
    _nickNameLabel = [[UILabel alloc] init];
    _nickNameLabel.text = @"用户昵称";
    _nickNameLabel.textColor = [UIColor whiteColor];
    _nickNameLabel.font = SuperBigBoldFont;
    _nickNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_nickNameLabel];
    [NSLayoutConstraint activateConstraints:@[
        [_nickNameLabel.topAnchor constraintEqualToAnchor:_avatarView.bottomAnchor constant:20],
        [_nickNameLabel.leadingAnchor constraintEqualToAnchor:_containerView.leadingAnchor constant:16],
        [_nickNameLabel.widthAnchor constraintEqualToConstant:150] // 设置宽度
    ]];
    
    // 简介
    _briefLabel = [[UILabel alloc] init];
    _briefLabel.text = @"个人简介。。。。。。。。。。。。。。。。。。。。。"; // todo:允许换行
    _briefLabel.textColor = [UIColor whiteColor];
    _briefLabel.font = SmallFont;
    _briefLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_briefLabel];
    [NSLayoutConstraint activateConstraints:@[
        [_briefLabel.topAnchor constraintEqualToAnchor:_nickNameLabel.bottomAnchor constant:5],
        [_briefLabel.leadingAnchor constraintEqualToAnchor:_containerView.leadingAnchor constant:16],
        [_briefLabel.widthAnchor constraintEqualToConstant:(ScreenWidth - 20)]
    ]];
}

// ================================================================================================
# pragma mark - Right Info
// ================================================================================================

- (void)initRightInfoView {
    //获赞
    _thumbNumLabel = [[UILabel alloc] init];
    _thumbNumLabel.text = @"1.0w";
    _thumbNumLabel.textColor = [UIColor whiteColor];
    _thumbNumLabel.font = MediumFont;
    _thumbNumLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_thumbNumLabel];
    [NSLayoutConstraint activateConstraints:@[
        [_thumbNumLabel.topAnchor constraintEqualToAnchor:_bottomBackground.topAnchor constant:5],
        [_thumbNumLabel.trailingAnchor constraintEqualToAnchor:_containerView.trailingAnchor constant:-16],
        [_thumbNumLabel.widthAnchor constraintEqualToConstant:40]
    ]];
    UILabel *thumbLabel = [[UILabel alloc] init];
    thumbLabel.text = @"获赞";
    thumbLabel.textColor = [UIColor grayColor];
    thumbLabel.font = MediumBoldFont;
    thumbLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:thumbLabel];
    [NSLayoutConstraint activateConstraints:@[
        [thumbLabel.topAnchor constraintEqualToAnchor:_thumbNumLabel.bottomAnchor constant:5],
        [thumbLabel.trailingAnchor constraintEqualToAnchor:_containerView.trailingAnchor constant:-16],
        [thumbLabel.widthAnchor constraintEqualToConstant:40]
    ]];
    //分割符
    UILabel *splitLabel0 = [self getSpliteLabel];
    [_containerView addSubview:splitLabel0];
    [NSLayoutConstraint activateConstraints:@[
        [splitLabel0.topAnchor constraintEqualToAnchor:_bottomBackground.topAnchor constant:10],
        [splitLabel0.trailingAnchor constraintEqualToAnchor:_thumbNumLabel.leadingAnchor constant:-5],
        [splitLabel0.widthAnchor constraintEqualToConstant:10]
    ]];
}



- (UILabel *)getSpliteLabel {
    UILabel *splitLabel = [[UILabel alloc] init];
    splitLabel.text = @"|";
    splitLabel.textColor = [UIColor grayColor];
    splitLabel.font = BigBoldFont;
    splitLabel.translatesAutoresizingMaskIntoConstraints = NO;
    return splitLabel;
}

// ================================================================================================
# pragma mark - Actions
// ================================================================================================

// 头像点击事件
- (void)onAvatarTapAction:(UITapGestureRecognizer *)sender {
    // todo
}

@end
