//
//  TTAddViewController.m
//  TimeThings
//
//  Created by caohouhong on 2018/7/21.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "TTAddViewController.h"
#import "TTDatePicker.h"
#import "CNPPopupController.h"
#import "TTClock.h"
#import "TTListModel.h"
#import "DataBase.h"

@interface TTAddViewController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UITextField *ThingsTF;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (strong, nonatomic) TTDatePicker *dateView;
@property (strong, nonatomic) CNPPopupController *popController;
@property (assign, nonatomic) int btnTag;
@property (strong, nonatomic) NSString *dateStr, *timeStr;
@property (assign, nonatomic) double timestamp;
@end

@implementation TTAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Add";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Finish" style:UIBarButtonItemStylePlain target:self action:@selector(finishAction:)];
    
    TTClock *clockView = [[TTClock alloc] initWithFrame:CGRectMake(0, 0, TTScreenWidth, 150)];
    clockView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:clockView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (TTDatePicker *)dateView {
    if (!_dateView){
        _dateView  = [[TTDatePicker alloc] initWithFrame:CGRectMake(0, TTScreenHeight -  TTTopFullHeight, TTScreenWidth, 200) andType:1];
        __weak typeof (self) weakSelf = self;
        _dateView.block = ^(NSString *dateStr, NSString *timeStr, double timestamp) {
            if (dateStr){
                weakSelf.dateStr = dateStr;
                weakSelf.timeStr = timeStr;
                weakSelf.timestamp = timestamp;
                [weakSelf.timeBtn setTitle:[NSString stringWithFormat:@"%@ %@",dateStr,timeStr] forState:UIControlStateNormal];
            }
            [weakSelf.popController dismissPopupControllerAnimated:YES];
        };
        _dateView.cancelBlock = ^{
            [weakSelf.popController dismissPopupControllerAnimated:YES];
        };
    }
    return _dateView;
}

- (IBAction)selectColorAction:(UIButton *)sender {
    
    self.btnTag = (int)sender.tag - 1000;
    self.colorBtn.backgroundColor = sender.backgroundColor;
}

- (IBAction)timeAction:(UIButton *)sender {
    self.popController = [[CNPPopupController alloc] initWithContents:@[self.dateView]];
    self.popController.theme.popupStyle = CNPPopupStyleActionSheet;
    self.popController.theme.shouldDismissOnBackgroundTouch = YES;
    [self.popController presentPopupControllerAnimated:YES];
}

- (IBAction)finishAction:(UIButton *)sender {
    if (self.titleTF.text.length <= 0){
        [LCProgressHUD showFailure:@"please input title"];
        return;
    }
    if (self.ThingsTF.text.length <= 0){
        [LCProgressHUD showFailure:@"please input things"];
        return;
    }
    TTListModel *model = [[TTListModel alloc] init];
    model.title = self.titleTF.text;
    model.things = self.ThingsTF.text;
    model.colorType = [NSNumber numberWithInt:self.btnTag];
    if (self.dateStr){
        model.dateStr = self.dateStr;
        model.timestamp =  [NSString stringWithFormat:@"%f",self.timestamp];
    }else {
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY.MM.dd"];
        model.dateStr = [formatter stringFromDate:[NSDate date]];
        model.timestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    }
    if (self.timeStr){
        model.timeStr = self.timeStr;
    }else {
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH.mm.ss"];
        model.timeStr = [formatter stringFromDate:[NSDate date]];
    }
    [[DataBase sharedDataBase] addListModel:model];
    [self.navigationController popViewControllerAnimated:YES];
    if (self.block){
        self.block();
    }
}
@end
