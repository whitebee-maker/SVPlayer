//
//  UserInfoHeader.m
//  SVPlayer
//
//  Created by weibin on 2025/1/20.
//

#import "UserInfoHeader.h"

#import "SlideTabBar.h"

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

@property(nonatomic, strong) UIButton *focusBtn;
@property(nonatomic, strong) UIButton *supportBtn;

@property(nonatomic, strong) SlideTabBar *slideTabBar;

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
    //_containerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_containerView];

    [self initAvatar];       // 头像
    [self iniLefttInfoView];  // 昵称、简介
    [self initRightInfoView]; // 关注、获赞、粉丝
    [self initBtns];         // 关注和支持
    [self initHeadTools];   //顶部工具按钮
    [self initFooter];
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
    _nickNameLabel.font = LargeBoldFont;
    _nickNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_nickNameLabel];
    [NSLayoutConstraint activateConstraints:@[
        [_nickNameLabel.topAnchor constraintEqualToAnchor:_avatarView.bottomAnchor constant:50],
        [_nickNameLabel.leadingAnchor constraintEqualToAnchor:_containerView.leadingAnchor constant:16],
        [_nickNameLabel.widthAnchor constraintEqualToConstant:150] // 设置宽度
    ]];
    
    // 简介
    _briefLabel = [[UILabel alloc] init];
    _briefLabel.text = @"个人简介。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。";
    _briefLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _briefLabel.numberOfLines = 0;
    _briefLabel.preferredMaxLayoutWidth = ScreenWidth - 20;
    _briefLabel.textColor = [UIColor whiteColor];
    _briefLabel.font = SmallFont;
    _briefLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_briefLabel];
    [NSLayoutConstraint activateConstraints:@[
        [_briefLabel.topAnchor constraintEqualToAnchor:_nickNameLabel.bottomAnchor constant:10],
        [_briefLabel.leadingAnchor constraintEqualToAnchor:_containerView.leadingAnchor constant:16],
        [_briefLabel.widthAnchor constraintEqualToConstant:(ScreenWidth - 20)]
    ]];
}

- (void)initRightInfoView {
    //获赞
    _thumbNumLabel = [[UILabel alloc] init];
    _thumbNumLabel.text = @"1.0w";
    _thumbNumLabel.textColor = [UIColor whiteColor];
    _thumbNumLabel.font = SmallFont;
    _thumbNumLabel.textAlignment = NSTextAlignmentCenter;
    _thumbNumLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_thumbNumLabel];
    [NSLayoutConstraint activateConstraints:@[
        [_thumbNumLabel.topAnchor constraintEqualToAnchor:_bottomBackground.topAnchor constant:5],
        [_thumbNumLabel.trailingAnchor constraintEqualToAnchor:_containerView.trailingAnchor constant:-16],
        [_thumbNumLabel.widthAnchor constraintEqualToConstant:50]
    ]];
    UILabel *thumbLabel = [[UILabel alloc] init];
    thumbLabel.text = @"获赞";
    thumbLabel.textColor = [UIColor grayColor];
    thumbLabel.font = MediumBoldFont;
    thumbLabel.textAlignment = NSTextAlignmentCenter;
    thumbLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:thumbLabel];
    [NSLayoutConstraint activateConstraints:@[
        [thumbLabel.topAnchor constraintEqualToAnchor:_thumbNumLabel.bottomAnchor constant:5],
        [thumbLabel.trailingAnchor constraintEqualToAnchor:_containerView.trailingAnchor constant:-16],
        [thumbLabel.widthAnchor constraintEqualToConstant:50]
    ]];
    UILabel *splitLabel0 = [self getSpliteLabel]; // 分割符
    [_containerView addSubview:splitLabel0];
    [NSLayoutConstraint activateConstraints:@[
        [splitLabel0.topAnchor constraintEqualToAnchor:_bottomBackground.topAnchor constant:10],
        [splitLabel0.trailingAnchor constraintEqualToAnchor:_thumbNumLabel.leadingAnchor constant:-5],
        [splitLabel0.widthAnchor constraintEqualToConstant:10]
    ]];
    
    // 关注
    _focusNumLabel = [[UILabel alloc] init];
    _focusNumLabel.text = @"20";
    _focusNumLabel.textColor = [UIColor whiteColor];
    _focusNumLabel.font = SmallFont;
    _focusNumLabel.textAlignment = NSTextAlignmentCenter;
    _focusNumLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_focusNumLabel];
    [NSLayoutConstraint activateConstraints:@[
        [_focusNumLabel.topAnchor constraintEqualToAnchor:_bottomBackground.topAnchor constant:5],
        [_focusNumLabel.trailingAnchor constraintEqualToAnchor:splitLabel0.trailingAnchor constant:-16],
        [_focusNumLabel.widthAnchor constraintEqualToConstant:50]
    ]];
    UILabel *focusLabel = [[UILabel alloc] init];
    focusLabel.text = @"关注";
    focusLabel.textColor = [UIColor grayColor];
    focusLabel.font = MediumBoldFont;
    focusLabel.textAlignment = NSTextAlignmentCenter;
    focusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:focusLabel];
    [NSLayoutConstraint activateConstraints:@[
        [focusLabel.topAnchor constraintEqualToAnchor:_focusNumLabel.bottomAnchor constant:5],
        [focusLabel.trailingAnchor constraintEqualToAnchor:splitLabel0.trailingAnchor constant:-16],
        [focusLabel.widthAnchor constraintEqualToConstant:50]
    ]];
    UILabel *splitLabel1 = [self getSpliteLabel]; // 分割符
    [_containerView addSubview:splitLabel1];
    [NSLayoutConstraint activateConstraints:@[
        [splitLabel1.topAnchor constraintEqualToAnchor:_bottomBackground.topAnchor constant:10],
        [splitLabel1.trailingAnchor constraintEqualToAnchor:_focusNumLabel.leadingAnchor constant:-5],
        [splitLabel1.widthAnchor constraintEqualToConstant:10]
    ]];
    
    // 粉丝
    _fansNumLabel = [[UILabel alloc] init];
    _fansNumLabel.text = @"200w";
    _fansNumLabel.textColor = [UIColor whiteColor];
    _fansNumLabel.font = SmallFont;
    _fansNumLabel.textAlignment = NSTextAlignmentCenter;
    _fansNumLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:_fansNumLabel];
    [NSLayoutConstraint activateConstraints:@[
        [_fansNumLabel.topAnchor constraintEqualToAnchor:_bottomBackground.topAnchor constant:5],
        [_fansNumLabel.trailingAnchor constraintEqualToAnchor:splitLabel1.trailingAnchor constant:-16],
        [_fansNumLabel.widthAnchor constraintEqualToConstant:50]
    ]];
    UILabel *fansLabel = [[UILabel alloc] init];
    fansLabel.text = @"粉丝";
    fansLabel.textColor = [UIColor grayColor];
    fansLabel.font = MediumBoldFont;
    fansLabel.textAlignment = NSTextAlignmentCenter;
    fansLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_containerView addSubview:fansLabel];
    [NSLayoutConstraint activateConstraints:@[
        [fansLabel.topAnchor constraintEqualToAnchor:_focusNumLabel.bottomAnchor constant:5],
        [fansLabel.trailingAnchor constraintEqualToAnchor:splitLabel1.trailingAnchor constant:-16],
        [fansLabel.widthAnchor constraintEqualToConstant:50]
    ]];
    UILabel *splitLabel2 = [self getSpliteLabel]; // 分割符
    [_containerView addSubview:splitLabel2];
    [NSLayoutConstraint activateConstraints:@[
        [splitLabel2.topAnchor constraintEqualToAnchor:_bottomBackground.topAnchor constant:10],
        [splitLabel2.trailingAnchor constraintEqualToAnchor:_fansNumLabel.leadingAnchor constant:-5],
        [splitLabel2.widthAnchor constraintEqualToConstant:10]
    ]];
}

- (UILabel *)getSpliteLabel {
    UILabel *splitLabel = [[UILabel alloc] init];
    splitLabel.text = @"|";
    splitLabel.textColor = [UIColor grayColor];
    splitLabel.font = BigBoldFont;
    splitLabel.textAlignment = NSTextAlignmentCenter;
    splitLabel.translatesAutoresizingMaskIntoConstraints = NO;
    return splitLabel;
}

- (void)initBtns {
    // 关注按钮
    _focusBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _focusBtn.backgroundColor = [UIColor systemPinkColor];
    [_focusBtn setTitle:@"+关注" forState:UIControlStateNormal];
    [_focusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _focusBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_focusBtn addTarget:self action:@selector(onFocusBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_focusBtn];
    [NSLayoutConstraint activateConstraints:@[
        [_focusBtn.topAnchor constraintEqualToAnchor:_bottomBackground.topAnchor constant:50],
        [_focusBtn.trailingAnchor constraintEqualToAnchor:_bottomBackground.trailingAnchor constant:-5],
        [_focusBtn.widthAnchor constraintEqualToConstant:80]
    ]];
    
    //支持按钮
    _supportBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _supportBtn.backgroundColor = [UIColor clearColor];
    _supportBtn.layer.borderWidth = 1.0;
    _supportBtn.layer.borderColor = [UIColor systemPinkColor].CGColor;
    [_supportBtn setTitle:@"支持" forState:UIControlStateNormal];
    [_supportBtn setTitleColor:[UIColor systemPinkColor] forState:UIControlStateNormal];
    _supportBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_supportBtn addTarget:self action:@selector(onSupportBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_supportBtn];
    [NSLayoutConstraint activateConstraints:@[
        [_supportBtn.topAnchor constraintEqualToAnchor:_bottomBackground.topAnchor constant:50],
        [_supportBtn.trailingAnchor constraintEqualToAnchor:_focusBtn.leadingAnchor constant:-5],
        [_supportBtn.widthAnchor constraintEqualToConstant:80]
    ]];
}

- (void)initHeadTools {
    // todo
}

- (void)initFooter {
    _slideTabBar = [SlideTabBar new];
    _slideTabBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_slideTabBar];
    [NSLayoutConstraint activateConstraints:@[
        [_slideTabBar.topAnchor constraintEqualToAnchor:self.bottomAnchor constant:-40],
        [_slideTabBar.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0],
        [_slideTabBar.heightAnchor constraintEqualToConstant:40],
        [_slideTabBar.widthAnchor constraintEqualToConstant:ScreenWidth]
    ]];
    [_slideTabBar setLabels:@[@"作品0",@"喜欢0"] tabIndex:0];
}

// ================================================================================================
# pragma mark - Actions
// ================================================================================================

// 头像点击事件
- (void)onAvatarTapAction:(UITapGestureRecognizer *)sender {
    // todo
}

// 关注按钮事件
- (void)onFocusBtnClicked:(UIButton *)sender {
    // todo
}

// 支持按钮事件
- (void)onSupportBtnClicked:(UIButton *)sender {
    // todo
}

// 分享点击事件
- (void)onShareTapAction:(UITapGestureRecognizer *)sender {
    // todo
}

@end
