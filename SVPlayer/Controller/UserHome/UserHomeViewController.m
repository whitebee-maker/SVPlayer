//
//  UserHomeViewController.m
//  SVPlayer
//
//  Created by xk on 2025/1/14.
//

#import "UserHomeViewController.h"

@interface UserHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation UserHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// ================================================================================================
# pragma mark - UICollectionViewDataSource Delegate
// ================================================================================================

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
