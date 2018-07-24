//
//  TTShowViewController.m
//  TimeThings
//
//  Created by caohouhong on 2018/7/23.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "TTShowViewController.h"
#import "DataBase.h"

@interface TTShowViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn;
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UITextField *thingsTF;

@end

@implementation TTShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Show";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editAction)];
    _timeLabel.text = [NSString stringWithFormat:@"%@ %@",_model.dateStr, _model.timeStr];
    [_colorBtn setBackgroundColor:_model.color];
    _titleTF.text = _model.title;
    _titleTF.enabled = NO;
    _thingsTF.text = _model.things;
    _thingsTF.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)editAction {
    _titleTF.enabled = YES;
    _thingsTF.enabled = YES;
    [_titleTF becomeFirstResponder];
}

- (IBAction)updateAction:(UIButton *)sender {
    if (_titleTF.text.length > 0){
        self.model.title = _titleTF.text;
    }
    if (_thingsTF.text.length > 0){
        self.model.things = _thingsTF.text;
    }
    [[DataBase sharedDataBase] updateModel:self.model];
    [self.navigationController popViewControllerAnimated:YES];
    if (self.updateblock){
        self.updateblock();
    }
}
- (IBAction)deleteAction:(UIButton *)sender {
    [[DataBase sharedDataBase] deleteModel:self.model];
    [self.navigationController popViewControllerAnimated:YES];
    if (self.deleteblock){
        self.deleteblock();
    }
}

@end
