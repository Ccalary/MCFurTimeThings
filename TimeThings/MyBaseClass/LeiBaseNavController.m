//
//  TTBaseNavController.m
//  TimeThings
//
//  Created by caohouhong on 2018/7/21.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "LeiBaseNavController.h"

@interface LeiBaseNavController ()

@end

@implementation LeiBaseNavController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO; //设置了之后自动下沉64
    
    self.navigationBar.barTintColor = [UIColor tt_themeColor];
    // 中间title颜色
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                 NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationBar.tintColor = [UIColor whiteColor]; // 左右颜色
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.viewControllers count] > 0){
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(tt_back)];
        viewController.navigationItem.leftBarButtonItem = backItem;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)tt_back{
    [self popViewControllerAnimated:YES];
}

@end
