//
//  TTListModel.h
//  TimeThings
//
//  Created by caohouhong on 2018/7/21.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTListModel : NSObject
@property (nonatomic, strong) NSNumber *r_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *things;
@property (nonatomic, strong) NSNumber *colorType;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, copy) NSString *dateStr;
@property (nonatomic, copy) NSString *timeStr;
@property (nonatomic, strong) NSDate *date;
@end
