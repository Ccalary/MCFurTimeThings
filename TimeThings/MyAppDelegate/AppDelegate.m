//
//  AppDelegate.m
//  TimeThings
//
//  Created by caohouhong on 2018/7/21.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "AppDelegate.h"
#import "LeiBaseTabController.h"
#import <UserNotifications/UserNotifications.h>
#import "MagicalRecord.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import <SDCycleScrollView/SDCycleScrollView.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[LeiBaseTabController alloc] init];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:0.5];
    [self localNotice];
    [MagicalRecord setupCoreDataStack];
    [self checkNetwork];
    SDCycleScrollView *scr = [[SDCycleScrollView alloc] init];
    NSLog(@"scr:%@",scr);
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Notification
- (void)localNotice {
    // 注册通知
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
    }];
}

//使用AFN框架来检测网络状态的改变
-(void)checkNetwork
{
    //1.创建网络监听管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {//1-无网络 2-数据网络 3-wifi 其他-未知网络
            case AFNetworkReachabilityStatusUnknown://未知
                [SVProgressHUD showInfoWithStatus:@"unknow"];
                break;
            case AFNetworkReachabilityStatusNotReachable://没有网络
                [SVProgressHUD showInfoWithStatus:@"no network"];
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN://数据网络
                [SVProgressHUD showInfoWithStatus:@"data network"];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi://wifi
                [SVProgressHUD showInfoWithStatus:@"wifi"];
                break;
            default:
                break;
        }
    }];
    //3.开始监听
    [manager startMonitoring];
}


@end
