//
//  TNOrderAddViewController.m
//  TimeNotes
//
//  Created by caohouhong on 2018/7/27.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "OrderViewController.h"
#import "TTOrder.h"
#import "Notice.h"

@interface OrderViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSString *detailStr;
@property (nonatomic) BOOL isOn;
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Add";
    self.view.backgroundColor = [UIColor lightGrayColor];
    _dataArray = @[@"Tip",@"Alert"];
    self.detailStr = @"order";
    [self Lei_drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)Lei_drawView {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(nav_leftBtnAction)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(navAction)];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, TTScreenWidth, TTScreenHeight - TTTopFullHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor lightGrayColor];
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, TTScreenWidth, 200)];
    _datePicker.backgroundColor = [UIColor whiteColor];
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    // 1.3设置datePickr的地区语言, zh_Han后面是s的就为简体中文,zh_Han后面是t的就为繁体中文
    [_datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    // 1.4监听datePickr的数值变化
    [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    // 2.3 将转换后的日期设置给日期选择控件
    [_datePicker setDate:[NSDate date]];
    
    [self.tableView setTableHeaderView:_datePicker];
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
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
      
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    if (indexPath.row == 0){
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = self.detailStr;
    }else if (indexPath.row == 1){
        UISwitch *rightSwitch = [[UISwitch alloc] init];
        [rightSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = rightSwitch;
        cell.detailTextLabel.text = @"";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0){
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)dateChanged:(UIDatePicker *)picker {
    
}

- (void)switchAction:(UISwitch *)mSwitch {
    self.isOn = mSwitch.isOn;
}

// 取消
- (void)nav_leftBtnAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 存储
- (void)nav_rightBtnAction {
    
    
    TTOrder *order = [[TTOrder alloc] init];

    order.timestamp = [NSString stringWithFormat:@"%f",[self.datePicker.date timeIntervalSince1970]];
    order.is_on = (self.isOn) ? @"1" : @"0";
    order.content = self.detailStr;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *creatTime = [formatter stringFromDate:[NSDate date]];
    order.creatTime = creatTime;
    [[LEIDataBase sharedDataBase] addOrderModel:order];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ADD_SUC object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
