//
//  TTDatePicker.h
//  TimeThings
//
//  Created by caohouhong on 2018/7/21.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^sureBlock)(NSString *dateStr, NSString *timeStr);
typedef void(^cancelBlock)(void);
@interface TTDatePicker : UIView
@property (nonatomic, copy) sureBlock block;
@property (nonatomic, copy) cancelBlock cancelBlock;

- (instancetype)initWithFrame:(CGRect)frame andType:(int)type;
@end
