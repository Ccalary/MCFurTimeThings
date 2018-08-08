//
//  TTMeViewController.m
//  TimeThings
//
//  Created by caohouhong on 2018/7/21.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "LeiMineVC.h"
#import "TTAddViewController.h"
#import "LeiInfoVC.h"
#import "TTContactViewController.h"
#import "OrderViewController.h"
#import "LeiBaseNavController.h"
#import "TNEmptyViewView.h"
#import <SDWebImage/SDImageCache.h>

@interface LeiMineVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIButton *headerButton;
@property (nonatomic, strong) UILabel *tipLabel;
@end

@implementation LeiMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"Record",@"Order",@"Addition",@"Contact",@"Version"];
    [self Lei_drawView];
    SDImageCache *cache = [[SDImageCache alloc] init];
    cache.maxMemoryCost = 10000;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)Lei_drawView {
    
    TNEmptyViewView *emView = [[TNEmptyViewView alloc] initWithFrame:CGRectZero];
    emView.hidden = YES;
    [self.view addSubview:emView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TTScreenWidth, 260)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, TTScreenWidth, 260)];
    imageView.image = [UIImage imageNamed:@"top_image"];
    [headerView addSubview:imageView];
    
    _headerButton = [[UIButton alloc] init];
    [_headerButton setBackgroundImage:[UIImage imageNamed:@"header"] forState:UIControlStateNormal];
    _headerButton.layer.cornerRadius = 50;
    _headerButton.layer.masksToBounds = YES;
    _headerButton.layer.borderWidth = 3;
    _headerButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [headerView addSubview:_headerButton];
    [_headerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.centerX.mas_equalTo(headerView);
        make.bottom.offset(-80);
    }];
    
    _tipLabel = [[UILabel alloc] init];
    _tipLabel.text = @"Welcom here";
    _tipLabel.textColor = [UIColor grayColor];
    [headerView addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-20);
        make.centerX.mas_equalTo(headerView);
    }];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSString *timeStr = [formatter stringFromDate:[NSDate date]];
    
    if ([timeStr intValue] < 12){
        _tipLabel.text = @"Good morning, Welcome here!";
    }else if ([timeStr intValue] > 20){
        _tipLabel.text = @"Good evening, Welcome here!";
    }else {
         _tipLabel.text = @"Good afternoon, Welcome here!";
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -TTStatusBarHeight, TTScreenWidth, TTScreenHeight - TTTabBarHeight + TTStatusBarHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = headerView;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.detailTextLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
    if (indexPath.row == self.dataArray.count - 1){//
        cell.detailTextLabel.text = [NSString stringWithFormat:@"v%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            LeiInfoVC *vc = [[LeiInfoVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            OrderViewController *addVC = [[OrderViewController alloc] init];
            LeiBaseNavController *nav = [[LeiBaseNavController alloc] initWithRootViewController:addVC];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
        }
            break;
        case 2:
        {
            TTAddViewController *vc = [[TTAddViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
           
            break;
        case 3:
            [self findOneEmail];
            break;
        default:
            break;
    }
}

- (void)findOneEmail {
    TTContactViewController *vc = [[TTContactViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
