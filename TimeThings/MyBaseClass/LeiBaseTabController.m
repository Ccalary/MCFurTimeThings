//
//  TTBaseTabController.m
//  TimeThings
//
//  Created by caohouhong on 2018/7/21.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "LeiBaseTabController.h"
#import "LeiBaseNavController.h"
#import "MainViewController.h"
#import "LeiMineVC.h"
#import "ClockViewController.h"

@interface LeiBaseTabController ()

@end

@implementation LeiBaseTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UITabBar appearance].tintColor = [UIColor tt_themeColor];
    [self addChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//添加子控制器
- (void)addChildViewControllers{
    
    [self addChildrenVC:[[ClockViewController alloc] init] title:@"Order" normalImageStr:@"t_clock"];
    [self addChildrenVC:[[MainViewController alloc] init] title:@"Note" normalImageStr:@"t_main"];
    [self addChildrenVC:[[LeiMineVC alloc] init] title:@"User" normalImageStr:@"t_me"];
}

- (void)addChildrenVC:(UIViewController *)childVC title:(NSString *)title normalImageStr:(NSString *)imageName{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:imageName];
    childVC.title = title;
    
    LeiBaseNavController *baseNav = [[LeiBaseNavController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:baseNav];
}

@end
