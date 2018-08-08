//
//  TTContactViewController.m
//  TimeThings
//
//  Created by caohouhong on 2018/7/24.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "TTContactViewController.h"

@interface TTContactViewController ()

@end

@implementation TTContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Contact";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
- (IBAction)copyAction:(UIButton *)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = sender.currentTitle;
    [SVProgressHUD showSuccessWithStatus:@"copy success!"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

@end
