//
//  AppDelegate.m
//  Recorder
//
//  Created by yingxin on 16/7/25.
//  Copyright © 2016年 yingxin. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftMenuViewController.h"
#import "RightMenuViewController.h"
#import "MainViewController.h"

@interface AppDelegate ()
@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    //侧边栏
    LeftMenuViewController *leftVC = [LeftMenuViewController new];
//    RightMenuViewController *rightVC = [RightMenuViewController new];
    MainViewController *mainVC = [MainViewController shareInstance];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:mainVC];
    RESideMenu *sideMenu = [[RESideMenu alloc] initWithContentViewController:navi leftMenuViewController:leftVC rightMenuViewController:nil];
    //背景图
    sideMenu.backgroundImage = [UIImage imageNamed:@"welcome1"];
    //是否允许手势触发界面的变化, 默认YES
    sideMenu.panGestureEnabled = YES;
    //表示滑动手势是否是从屏幕边缘触发
    sideMenu.panFromEdge = NO;
    //菜单是否要渐入.. 背景色由浅到深
    sideMenu.fadeMenuView = NO;
    //是否缩放内容页
    sideMenu.scaleContentView = NO;
    //是否缩放背景图
    sideMenu.scaleBackgroundImageView = NO;
    //内容页的最大偏移量
    //sideMenu.contentViewInPortraitOffsetCenterX = [UIScreen mainScreen].bounds.size.width / 2 - 60;
    sideMenu.contentViewInPortraitOffsetCenterX = -([UIScreen mainScreen].bounds.size.width / 2 - 100);
    //是否允许滑动时的弹簧效果(貌似有BUG)
    sideMenu.bouncesHorizontally = YES;
    //必须是scaleContentView属性为YES时, 才有效
    sideMenu.menuPrefersStatusBarHidden = YES;
    _window.rootViewController = sideMenu;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
