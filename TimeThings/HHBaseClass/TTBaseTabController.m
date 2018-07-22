//
//  TTBaseTabController.m
//  TimeThings
//
//  Created by caohouhong on 2018/7/21.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "TTBaseTabController.h"
#import "TTBaseNavController.h"
#import "TTHomeViewController.h"
#import "TTMeViewController.h"

@interface TTBaseTabController ()

@end

@implementation TTBaseTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UITabBar appearance].tintColor = [UIColor tt_themeColor];
    [self mc_addChildVCs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//添加子控制器
- (void)mc_addChildVCs{
    
    [self mc_addVC:[[TTHomeViewController alloc] init] title:@"Things" normalImageStr:@"t_list" selectImageStr:@"t_list"];
    [self mc_addVC:[[TTMeViewController alloc] init] title:@"User" normalImageStr:@"t_mine" selectImageStr:@"t_mine"];
}

- (void)mc_addVC:(UIViewController *)childVC title:(NSString *)title normalImageStr:(NSString *)imageName selectImageStr:(NSString *)selectedImage{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:selectedImage];
    childVC.title = title;
    
    TTBaseNavController *baseNav = [[TTBaseNavController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:baseNav];
}

@end
