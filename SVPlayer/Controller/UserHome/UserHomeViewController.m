//
//  UserHomeViewController.m
//  SVPlayer
//
//  Created by xk on 2025/1/14.
//

#import "UserHomeViewController.h"

#import "User.h"
#import "UserRequest.h"
#import "SlideTabBar.h"
#import "LoadMoreView.h"
#import "UserInfoHeader.h"
#import "UserHomeCollectionLayout.h"

#define kUserInfoHeaderHeight          350 + SafeAreaTopHeight

NSString *const USER_INFO_ID = @"UserInfoCell";

@interface UserHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UserInfoHeaderDelegate>

@property(nonatomic, strong) User                  *user;
@property(nonatomic, strong) NSString              *uid;

@property(nonatomic, strong) UICollectionView      *collectionView;
@property(nonatomic, strong) UserInfoHeader        *userInfoHeader;
@property(nonatomic, strong) LoadMoreView          *loadMoreView;

@property(nonatomic, assign) NSInteger             tabIndex;  // 0: 我的作品 | 1: 喜欢的作品
@property(nonatomic, assign) CGFloat               itemWidth;
@property(nonatomic, assign) CGFloat               itemHeight;
@property(nonatomic, strong) NSMutableArray        *myVideos;
@property(nonatomic, strong) NSMutableArray        *favoriteVideos;

@end

@implementation UserHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCollectionView];
}

- (void)initCollectionView {
    _itemWidth = (ScreenWidth - (CGFloat)(((NSInteger)(ScreenWidth)) % 3) ) / 3.0f - 1.0f;
    _itemHeight = _itemWidth * 1.35f;
    
    UserHomeCollectionLayout *layout = [[UserHomeCollectionLayout alloc] init];
    layout.minimumLineSpacing = 1;        // 行间距
    layout.minimumInteritemSpacing = 0;   //列间距
    _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    _collectionView.alwaysBounceVertical = YES;     // 垂直滚动反弹
    _collectionView.showsVerticalScrollIndicator = NO; // 不显示滚动条
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UserInfoHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:USER_INFO_ID];
    [self.view addSubview:_collectionView];
    
    _loadMoreView = [[LoadMoreView alloc] initWithFrame:CGRectMake(0, kUserInfoHeaderHeight, ScreenWidth, 30)];
    [_collectionView addSubview:_loadMoreView];
}

// ================================================================================================
# pragma mark - UICollectionViewDataSource Delegate
// ================================================================================================

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 1) {
        return _tabIndex == 0 ? _myVideos.count : _favoriteVideos.count;
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    // header和footer的数据源在次处理
    if (indexPath.section == 0 && kind == UICollectionElementKindSectionHeader) {
        UserInfoHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:USER_INFO_ID forIndexPath:indexPath];
        _userInfoHeader = header;
        _userInfoHeader.delegate = self;
        return header;
    }
    return [UICollectionReusableView new];
}

// ================================================================================================
# pragma mark - UICollectionViewDelegate Delegate
// ================================================================================================



// ================================================================================================
# pragma mark - UICollectionFlowLayout Delegate
// ================================================================================================

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(ScreenWidth, kUserInfoHeaderHeight);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

// ================================================================================================
# pragma mark - UIScrollViewDelegate Delegate
// ================================================================================================

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    [_userInfoHeader verticalScrollAction: offsetY];
}


// ================================================================================================
# pragma mark - Actions
// ================================================================================================

- (void)onUserInfoHeaderActionTap:(NSInteger)tabIndex {
    _tabIndex = tabIndex;
}


// ================================================================================================
# pragma mark - Init Data
// ================================================================================================

- (void)loadUserData {
    __weak typeof (self) wself = self;
    [UserRequest getUserDataByUid:_uid success:^(NSDictionary * _Nonnull responseData) {
        
    }];
}

@end
