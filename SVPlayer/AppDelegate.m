//
//  AppDelegate.m
//  SVPlayer
//
//  Created by xk on 2025/1/14.
//

#import "AppDelegate.h"
#import "SVTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    //显示window
    [self.window makeKeyAndVisible];
    
    //创建分栏控制器
    SVTabBarViewController *tabBarController = [[SVTabBarViewController alloc] init];
    self.window.rootViewController = tabBarController;
    
    return YES;
}

@end
