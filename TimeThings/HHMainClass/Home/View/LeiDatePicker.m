//
//  TTDatePicker.m
//  TimeThings
//
//  Created by caohouhong on 2018/7/21.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "LeiDatePicker.h"
@interface LeiDatePicker()
@property (nonatomic, strong) NSString *dateStr, *timeStr;
@property (nonatomic, assign) int type;
@property (nonatomic, assign) double timestamp;
@end
@implementation LeiDatePicker

- (instancetype)initWithFrame:(CGRect)frame andType:(int)type{
    if (self = [super initWithFrame:frame]){
        self.type = type;
        [self tt_initView];
    }
    return self;
}

- (void)tt_initView {
    
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 100, 25)];
    [cancel setTitle:@"cancel" forState:UIControlStateNormal];
    cancel.tag = 665;
    [cancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor tt_themeColor] forState:UIControlStateNormal];
    [self addSubview:cancel];
    
    UIButton *sure = [[UIButton alloc] initWithFrame:CGRectMake(TTScreenWidth - 100, 5, 100, 25)];
    [sure setTitle:@"sure" forState:UIControlStateNormal];
    sure.tag = 666;
    [sure addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [sure setTitleColor:[UIColor tt_themeColor] forState:UIControlStateNormal];
    [self addSubview:sure];
    
    // 1.日期Picker
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height - 30)];
    datePicker.backgroundColor = [UIColor whiteColor];
    // 1.1选择datePickr的显示风格
    if (self.type == 1){
       [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    }else if (self.type == 2){
       [datePicker setDatePickerMode:UIDatePickerModeDate];
    }
   
    // 1.2查询所有可用的地区
    //NSLog(@"%@", [NSLocale availableLocaleIdentifiers]);
    // 1.3设置datePickr的地区语言, zh_Han后面是s的就为简体中文,zh_Han后面是t的就为繁体中文
    [datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    // 1.4监听datePickr的数值变化
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    // 2.3 将转换后的日期设置给日期选择控件
    [datePicker setDate:[NSDate date]];
    [self addSubview:datePicker];
}

- (void)dateChanged:(UIDatePicker *)picker{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY.MM.dd"];
    _dateStr = [formatter stringFromDate:picker.date];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm:ss"];
    _timeStr = [timeFormatter stringFromDate:picker.date];
    self.timestamp = [picker.date timeIntervalSince1970];
}



- (void)cancelAction {
    if (self.cancelBlock){
        self.cancelBlock();
    }
}

- (void)buttonAction:(UIButton *)button {
    if (self.dateStr.length == 0){
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY.MM.dd"];
        _dateStr = [formatter stringFromDate:[NSDate date]];
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"HH:mm:ss"];
        _timeStr = [timeFormatter stringFromDate:[NSDate date]];
        self.timestamp = [[NSDate date] timeIntervalSince1970];
    }
    if (self.block){
        self.block(self.dateStr,self.timeStr,self.timestamp);
    }
}
@end
