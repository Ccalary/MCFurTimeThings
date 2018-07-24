//
//  TTMeViewController.m
//  TimeThings
//
//  Created by caohouhong on 2018/7/21.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "TTMeViewController.h"
#import "TTAddViewController.h"
#import "TTInfoViewController.h"
#import <StoreKit/StoreKit.h>
#import "TTContactViewController.h"

#define KAPPID @""

@interface TTMeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIButton *headerButton;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation TTMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"Info",@"Add",@"Contact",@"Version"];
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)drawView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TTScreenWidth, 260)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, TTScreenWidth, 260)];
    imageView.image = [UIImage imageNamed:@"top_image"];
    [headerView addSubview:imageView];
    
    _headerButton = [[UIButton alloc] init];
    [_headerButton setBackgroundImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
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
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"Welcom here";
    _nameLabel.textColor = [UIColor grayColor];
    [headerView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-20);
        make.centerX.mas_equalTo(headerView);
    }];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSString *timeStr = [formatter stringFromDate:[NSDate date]];
    
    if ([timeStr intValue] < 12){
        _nameLabel.text = @"Good morning, Welcome here!";
    }else if ([timeStr intValue] > 20){
        _nameLabel.text = @"Good evening, Welcome here!";
    }else {
         _nameLabel.text = @"Good afternoon, Welcome here!";
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
            TTInfoViewController *vc = [[TTInfoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            TTAddViewController *vc = [[TTAddViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
           
            break;
        case 2:
            [self tt_email];
            break;
        default:
            break;
    }
}

- (void)tt_evaluate {
    if (@available(iOS 10.3, *)) {
        [SKStoreReviewController requestReview];
    } else {
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", KAPPID];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
    }
}

- (void)tt_email {
    TTContactViewController *vc = [[TTContactViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
