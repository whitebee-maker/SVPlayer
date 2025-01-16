//
//  SVTabBarViewController.m
//  SVPlayer
//
//  Created by xk on 2025/1/14.
//

#import "SVTabBarViewController.h"

#import "UserHomeViewController.h"
#import "VideoTableViewController.h"

@interface SVTabBarViewController ()

@end

@implementation SVTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setBarTintColor:[UIColor blackColor]];
    [self.tabBar setTintColor:[UIColor whiteColor]];
    
    UserHomeViewController *userHomeVC = [[UserHomeViewController alloc] init];
    VideoTableViewController *videoTableVC = [[VideoTableViewController alloc] init];
    
    [userHomeVC setTitle:@"我的"];
    [videoTableVC setTitle:@"视频"];
    
    UINavigationController *videoTableNavigationController = [[UINavigationController alloc] initWithRootViewController:videoTableVC];
    UINavigationController *userHomeNavigationController = [[UINavigationController alloc] initWithRootViewController:userHomeVC];
    
    UIFont *customFont = [UIFont fontWithName:@"Arial-BoldMT" size:14.0]; // 自定义字体和大小
    NSDictionary *attributes = @{NSFontAttributeName: customFont};
    [[UITabBarItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    [self setViewControllers:@[videoTableNavigationController, userHomeNavigationController]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
