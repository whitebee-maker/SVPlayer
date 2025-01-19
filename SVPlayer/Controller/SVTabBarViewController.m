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
    
    
    NSDictionary *normalAttributes = @{
        NSFontAttributeName: [UIFont systemFontOfSize:20.0 weight:UIFontWeightRegular],
        NSForegroundColorAttributeName: [UIColor grayColor]
    };
    [[UITabBarItem appearance] setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];

    NSDictionary *selectedAttributes = @{
        NSFontAttributeName: [UIFont systemFontOfSize:20.0 weight:UIFontWeightBold],
        NSForegroundColorAttributeName: [UIColor whiteColor]
    };
    
    if (@available(iOS 15.0, *)) {
        UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
        UITabBarItemAppearance *itemAppearance = [[UITabBarItemAppearance alloc] init];
        [appearance configureWithOpaqueBackground]; // 设置为不透明
        appearance.backgroundColor = [UIColor blackColor]; // 设置背景颜色
        //自定义字体
        itemAppearance.normal.titleTextAttributes = normalAttributes;
        itemAppearance.selected.titleTextAttributes = selectedAttributes;
        appearance.stackedLayoutAppearance = itemAppearance;
        self.tabBar.standardAppearance = appearance;
        self.tabBar.scrollEdgeAppearance = appearance;
    } else {
        [[UITabBarItem appearance] setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
        self.tabBar.barTintColor = [UIColor blueColor];
        self.tabBar.translucent = NO;
    }
    
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
