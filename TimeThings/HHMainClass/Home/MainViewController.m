//
//  TTHomeViewController.m
//  TimeThings
//
//  Created by caohouhong on 2018/7/21.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MainViewController.h"
#import "TTAddViewController.h"
#import "TTHomeTableViewCell.h"
#import "LEIDataBase.h"
#import "LeiDatePicker.h"
#import "CNPPopupController.h"
#import "LeiNothingView.h"
#import "TTShowViewController.h"
#import "LeiEmptyView.h"

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) CNPPopupController *popController;
@property (nonatomic, strong) LeiDatePicker *dateView;
@property (nonatomic, strong) NSString *dateStr;
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) LeiNothingView *nothingView;
@property (nonatomic, strong) LeiEmptyView *emptyView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawView];
    [self loadSomeData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (LeiNothingView *)nothingView {
    if (!_nothingView){
        __weak typeof (self) weakSelf = self;
        _nothingView = [[LeiNothingView alloc] initWithFrame:CGRectMake(0, 0, TTScreenWidth, TTScreenHeight - TTTopFullHeight - TTTabBarHeight) addAction:^{
            [weakSelf Lei_addSomeThingAction];
        }];
    }
    return _nothingView;
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
- (LeiDatePicker *)dateView {
    if (!_dateView){
        _dateView  = [[LeiDatePicker alloc] initWithFrame:CGRectMake(0, TTScreenHeight -  TTTopFullHeight, TTScreenWidth, 200) andType:2];
        __weak typeof (self) weakSelf = self;
        _dateView.block = ^(NSString *dateStr, NSString *timeStr, double timeStamp) {
            if (dateStr){
                weakSelf.dataArray = [[LEIDataBase sharedDataBase] getListModelWithDate:dateStr];
                weakSelf.tableView.tableHeaderView = weakSelf.headerLabel;
                weakSelf.headerLabel.text = dateStr;
                [weakSelf refreshView];
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
    self.emptyView = [[LeiEmptyView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.emptyView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"date_25"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnAction)];
    
      self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reset_25"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction)];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, TTScreenWidth, TTScreenHeight - TTTopFullHeight - TTTabBarHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    _addBtn = [[UIButton alloc] init];
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"add_40"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(Lei_addSomeThingAction) forControlEvents:UIControlEventTouchUpInside];
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
    TTShowViewController *showVC = [[TTShowViewController alloc] init];
    showVC.model = self.dataArray[indexPath.row];
    __weak typeof (self) weakSelf = self;
    showVC.updateblock = ^{
        [SVProgressHUD showSuccessWithStatus:@"update success!"];
        [weakSelf loadSomeData];
    };
    showVC.deleteblock = ^{
        [SVProgressHUD showSuccessWithStatus:@"delete success!"];
        [weakSelf loadSomeData];
    };
    [self.navigationController pushViewController:showVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

//走了左滑删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){//删除操作
        TTListModel *model = self.dataArray[indexPath.row];
        [[LEIDataBase sharedDataBase] deleteModel:model];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        //删除某行并配有动画
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    }
}

//更改左滑后的字体显示
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    //如果系统是英文，会显示delete,这里可以改成自己想显示的内容
    return @"delete";
}

- (void)loadSomeData {
    self.dataArray = [[LEIDataBase sharedDataBase] getAllModel];
    [self refreshView];
    self.tableView.tableHeaderView = [[UIView alloc] init];
}

- (void)refreshView {
    if (self.dataArray.count == 0){
        self.addBtn.hidden = YES;
        [self.view addSubview:self.nothingView];
    }else {
        self.addBtn.hidden = NO;
        [self.nothingView removeFromSuperview];
    }
    [self.tableView reloadData];
}

- (void)leftBtnAction {
    [self loadSomeData];
}

- (void)rightBtnAction {
    self.popController = [[CNPPopupController alloc] initWithContents:@[self.dateView]];
    self.popController.theme.popupStyle = CNPPopupStyleActionSheet;
    self.popController.theme.shouldDismissOnBackgroundTouch = YES;
    [self.popController presentPopupControllerAnimated:YES];
}

- (void)Lei_addSomeThingAction {
    TTAddViewController *addVC = [[TTAddViewController alloc] init];
    __weak typeof (self) weakSelf = self;
    addVC.block = ^{
        [SVProgressHUD showSuccessWithStatus:@"Add success!"];
        [weakSelf loadSomeData];
    };
    [self.navigationController pushViewController:addVC animated:YES];
}
@end
