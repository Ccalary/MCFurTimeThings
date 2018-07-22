//
//  TTHomeViewController.m
//  TimeThings
//
//  Created by caohouhong on 2018/7/21.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "TTHomeViewController.h"
#import "TTAddViewController.h"
#import "TTHomeTableViewCell.h"
#import "DataBase.h"
#import "TTDatePicker.h"
#import "CNPPopupController.h"

@interface TTHomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) CNPPopupController *popController;
@property (nonatomic, strong) TTDatePicker *dateView;
@property (nonatomic, strong) NSString *dateStr;
@property (nonatomic, strong) UILabel *headerLabel;
@end

@implementation TTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawView];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (UILabel *)headerLabel {
    if (!_headerLabel){
        _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TTScreenWidth, 40)];
        _headerLabel.textColor = [UIColor grayColor];
        _headerLabel.backgroundColor = [UIColor tt_colorWithHex:0xf2f2f2];
        _headerLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _headerLabel;
}
- (TTDatePicker *)dateView {
    if (!_dateView){
        _dateView  = [[TTDatePicker alloc] initWithFrame:CGRectMake(0, TTScreenHeight -  TTTopFullHeight, TTScreenWidth, 200) andType:2];
        __weak typeof (self) weakSelf = self;
        _dateView.block = ^(NSString *dateStr, NSString *timeStr) {
            if (dateStr){
                weakSelf.dataArray = [[DataBase sharedDataBase] getListModelWithDate:dateStr];
                weakSelf.tableView.tableHeaderView = weakSelf.headerLabel;
                weakSelf.headerLabel.text = dateStr;
                [weakSelf.tableView reloadData];
            }
            [weakSelf.popController dismissPopupControllerAnimated:YES];
        };
        _dateView.cancelBlock = ^{
            [weakSelf.popController dismissPopupControllerAnimated:YES];
        };
    }
    return _dateView;
}

- (void)drawView{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"date_25"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnAction)];
    
      self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reset_25"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction)];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, TTScreenWidth, TTScreenHeight - TTTopFullHeight - TTTabBarHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    _addBtn = [[UIButton alloc] init];
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"add_40"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.right.mas_equalTo(self.view).offset(-5);
        make.bottom.mas_equalTo(self.view).offset(-TTTabBarHeight - 15);
    }];
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
    TTHomeTableViewCell *cell = (TTHomeTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TTHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)requestData {
    self.dataArray = [[DataBase sharedDataBase] getAllModel];
    [self.tableView reloadData];
    self.tableView.tableHeaderView = [[UIView alloc] init];
}

- (void)leftBtnAction {
    [self requestData];
}

- (void)rightBtnAction {
    self.popController = [[CNPPopupController alloc] initWithContents:@[self.dateView]];
    self.popController.theme.popupStyle = CNPPopupStyleActionSheet;
    self.popController.theme.shouldDismissOnBackgroundTouch = YES;
    [self.popController presentPopupControllerAnimated:YES];
}

- (void)addAction {
    TTAddViewController *addVC = [[TTAddViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
}
@end
