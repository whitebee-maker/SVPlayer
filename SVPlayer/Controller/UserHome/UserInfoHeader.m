//
//  UserInfoHeader.m
//  SVPlayer
//
//  Created by weibin on 2025/1/20.
//

#import "UserInfoHeader.h"

@interface UserInfoHeader()

@property(nonatomic, strong) UIView *containerView;
@property(nonatomic, strong) UIImageView *topBackground;
@property(nonatomic, strong) UIImageView *bottomBackground;
@property(nonatomic, strong) UIImageView *avatar;

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
//    _containerView.backgroundColor = [UIColor greenColor]; // todo
    [self addSubview:_containerView];

    [self initAvatar];
}

- (void)initBackground {
    _topBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50 + SafeAreaTopHeight)];
    _topBackground.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_topBackground];
    
    _bottomBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40 + SafeAreaTopHeight, ScreenWidth, self.bounds.size.height - (40 + SafeAreaTopHeight))];
    _bottomBackground.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_bottomBackground];

    UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    visualEffectView.frame = _bottomBackground.bounds;
    visualEffectView.alpha = 1;
    [_bottomBackground addSubview:visualEffectView];

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [self createBezierPath].CGPath;
    _bottomBackground.layer.mask = maskLayer;
}

-(UIBezierPath *)createBezierPath {
    int avatarRadius = 50;
    int topOffset = 16;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, topOffset)];
    [bezierPath addLineToPoint:CGPointMake(25, topOffset)];
    [bezierPath addArcWithCenter:CGPointMake(25 + avatarRadius * cos(M_PI/4), avatarRadius * sin(M_PI/4) + topOffset) radius:avatarRadius startAngle:(M_PI * 5)/4 endAngle:(M_PI * 7)/4 clockwise:YES];
    [bezierPath addLineToPoint:CGPointMake(25 + avatarRadius * cos(M_PI/4), topOffset)];
    [bezierPath addLineToPoint:CGPointMake(ScreenWidth, topOffset)];
    [bezierPath addLineToPoint:CGPointMake(ScreenWidth, self.bounds.size.height - (50 + SafeAreaTopHeight) + topOffset - 1)];
    [bezierPath addLineToPoint:CGPointMake(0, self.bounds.size.height - (50 + SafeAreaTopHeight) + topOffset - 1)];
    [bezierPath closePath];
    return bezierPath;
}

- (void)initAvatar {
    // 初始化头像
    _avatar = [[UIImageView alloc] init];
    _avatar.image = [UIImage imageNamed:@"img_find_default"];
    _avatar.tag = UserInfoHeaderAvatarTag;
    _avatar.userInteractionEnabled = YES;
    [_avatar addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAvatarTapAction:)]];
    _avatar.translatesAutoresizingMaskIntoConstraints = NO; // 取消自动布局约束
    [_containerView addSubview:_avatar];
    
    // 添加约束
    _avatar.layer.cornerRadius = _avatar.frame.size.width / 2;
    _avatar.clipsToBounds = YES;
    [NSLayoutConstraint activateConstraints:@[
        [_avatar.topAnchor constraintEqualToAnchor:_containerView.safeAreaLayoutGuide.topAnchor constant:40],
        [_avatar.leadingAnchor constraintEqualToAnchor:_containerView.leadingAnchor constant:16],
        [_avatar.widthAnchor constraintEqualToConstant:100], // 设置宽度
        [_avatar.heightAnchor constraintEqualToConstant:100] // 设置高度
    ]];
}

// ================================================================================================
# pragma mark - Actions
// ================================================================================================

- (void)onAvatarTapAction:(UITapGestureRecognizer *)sender {
    // todo
}

@end
