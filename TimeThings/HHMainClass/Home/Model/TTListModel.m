//
//  TTListModel.m
//  TimeThings
//
//  Created by caohouhong on 2018/7/21.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "TTListModel.h"

@implementation TTListModel
- (UIColor *)color {
    int type = [self.colorType intValue];
    switch (type) {
        case 0:
            return [UIColor tt_colorWithHex:0x2eb75d];
            break;
        case 1:
            return [UIColor tt_colorWithHex:0x929292];
            break;
        case 2:
            return [UIColor tt_colorWithHex:0x1a98fc];
            break;
        case 3:
            return [UIColor tt_colorWithHex:0xfc2a1c];
            break;
        case 4:
            return [UIColor tt_colorWithHex:0xfd7f7c];
            break;
        case 5:
            return [UIColor tt_colorWithHex:0xd687fc];
            break;
        default:
            return [UIColor tt_colorWithHex:0x2eb75d];
            break;
    }
}

- (NSDate *)date{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY.MM.dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:self.dateStr];
    return date;
}
@end
