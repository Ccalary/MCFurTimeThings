//
//  ClockViewController.m
//  TimeNote
//
//  Created by caohouhong on 2018/8/8.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "ClockViewController.h"
#import "TNOrderTableViewCell.h"
#import "TTOrder.h"
#import "LeiZaiLocalNotifi.h"
#import "Notice.h"
#import "OrderViewController.h"
#import "LeiBaseNavController.h"

@interface ClockViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *emptyView;

@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self lei_setUpView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addOrderSuccess) name:NOTIFICATION_ADD_SUC object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
}

- (UIView *)emptyView {
    if (!_emptyView){
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TTScreenWidth, TTScreenHeight - TTTopFullHeight - TTTabBarHeight)];
        UILabel *tipsLabel = [[UILabel alloc] init];
        tipsLabel.text = @"No Order Here!";
        tipsLabel.textColor = [UIColor grayColor];
        tipsLabel.font = [UIFont boldSystemFontOfSize:24];
        [_emptyView addSubview:tipsLabel];
        [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.emptyView);
            make.top.offset((TTScreenHeight - TTTopFullHeight - TTTabBarHeight)/2.0-10);
        }];
    }
    return _emptyView;
}

- (void)lei_setUpView {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_25"] style:UIBarButtonItemStylePlain target:self action:@selector(navAction)];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, TTScreenWidth, TTScreenHeight - TTTopFullHeight - TTTabBarHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    TNOrderTableViewCell *cell = (TNOrderTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TNOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    __weak typeof (self) weakSelf = self;
    cell.block = ^(BOOL isOn, NSUInteger row) {
        TTOrder *order = self.dataArray[row];
        order.is_on = isOn ? @"1" : @"0";
        [weakSelf reloadRowAtRow:row];
    };
    cell.orderModel = self.dataArray[indexPath.row];
    cell.indexPath = indexPath;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

// 刷新某一行
- (void)reloadRowAtRow:(NSUInteger)row{
    NSArray *position = @[[NSIndexPath indexPathForRow:row inSection:0]];
    [self.tableView reloadRowsAtIndexPaths:position withRowAnimation:UITableViewRowAnimationNone];
}

// 加载数据
- (void)requestData{
    NSArray *array = [[LEIDataBase sharedDataBase] getAllOrder];
    self.dataArray = [NSMutableArray arrayWithArray:array];
    NSError *error = nil;
    for (TTOrder *order in self.dataArray) {
        NSTimeInterval nowTimestamp = [[NSDate date] timeIntervalSince1970];
        double timeDif = [[NSString stringWithFormat:@"%@",order.timestamp] doubleValue] - nowTimestamp;
        if (timeDif < 60){
            [SVProgressHUD showInfoWithStatus:@"overdue data will be deleted"];
            [[LEIDataBase sharedDataBase] deleteOrder:order];
            [self.dataArray removeObject:order];
        }
    }
    if (error) {
        NSLog(@"error = %@", error);
    }
    
    [LeiZaiLocalNotifi removeAllNotification];
    [self.tableView reloadData];
    if (self.dataArray.count == 0){
        [self.view addSubview:self.emptyView];
    }else {
        [self.emptyView removeFromSuperview];
    }
}

- (void)navAction {
    OrderViewController *addVC = [[OrderViewController alloc] init];
    LeiBaseNavController *nav = [[LeiBaseNavController alloc] initWithRootViewController:addVC];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)addOrderSuccess {
    [self requestData];
}

@end
