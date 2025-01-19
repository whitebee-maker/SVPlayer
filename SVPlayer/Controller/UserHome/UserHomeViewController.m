//
//  UserHomeViewController.m
//  SVPlayer
//
//  Created by xk on 2025/1/14.
//

#import "UserHomeViewController.h"
#import "UserHomeCollectionLayout.h"
#import "UserInfoHeader.h"

@interface UserHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *collectionView;

@end

@implementation UserHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCollectionView];
}

- (void)initCollectionView {
    UserHomeCollectionLayout *layout = [[UserHomeCollectionLayout alloc] init];
    layout.minimumLineSpacing = 1;        // 行间距
    layout.minimumInteritemSpacing = 0;   //列间距
    _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    _collectionView.alwaysBounceVertical = YES;     // 垂直滚动反弹
    _collectionView.showsVerticalScrollIndicator = NO; // 不显示滚动条
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UserInfoHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UserInfoCell"];
    [self.view addSubview:_collectionView];
}

// ================================================================================================
# pragma mark - UICollectionViewDataSource Delegate
// ================================================================================================

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
