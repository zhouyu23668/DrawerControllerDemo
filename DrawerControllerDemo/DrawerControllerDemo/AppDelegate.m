//
//  AppDelegate.m
//  DrawerControllerDemo
//
//  Created by 周宇 on 13-8-29.
//  Copyright (c) 2013年 周宇. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "LeftViewController.h"
#import "CenterViewController.h"
#import "RightViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
@interface AppDelegate ()
@property (nonatomic,strong) MMDrawerController * drawerController;
@end

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initWithDrawerNavigation];
    return YES;
}

#pragma mark -
#pragma mark -ReloadScrollViewDelegate
- (void)initWithDrawerNavigation {
    UIViewController *leftSideDrawerViewController = [[LeftViewController alloc] init];
    
    UIViewController *centerViewController = [[CenterViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    UIViewController *rightSideDrawerViewController = [[RightViewController alloc] init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
    [navigationController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
    
    self.drawerController = [[MMDrawerController alloc]
                             initWithCenterViewController:navigationController
                             leftDrawerViewController:leftSideDrawerViewController
                             rightDrawerViewController:rightSideDrawerViewController]; // 配置左右侧边栏,哪一侧不需要则传入nil即可
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    // 配置侧边栏 start
    [self.drawerController setMaximumRightDrawerWidth:250.0];// 侧边栏展开的宽度
    [self.drawerController setMaximumLeftDrawerWidth:250.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];// 打开侧边栏的方式
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];// 关闭侧边栏的方式
    [self.drawerController setShowsShadow:YES];// 设置是否有阴影
    [self.drawerController setCenterHiddenInteractionMode:MMDrawerOpenCenterInteractionModeNone];
    [self.drawerController setShouldStretchDrawer:YES];// 侧边栏拉伸动画
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor]; // 配置侧边栏动画
    [[MMExampleDrawerVisualStateManager sharedManager] setRightDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor]; // 配置侧边栏动画
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];

    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [self.window setRootViewController:self.drawerController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
