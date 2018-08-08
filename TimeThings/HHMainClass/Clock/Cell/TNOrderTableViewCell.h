//
//  TNOrderTableViewCell.h
//  TimeNotes
//
//  Created by caohouhong on 2018/7/25.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTOrder.h"

typedef void(^switchBlock)(BOOL isOn, NSUInteger row);
@interface TNOrderTableViewCell : UITableViewCell
@property (nonatomic, strong) TTOrder *orderModel;
@property (nonatomic, copy) switchBlock block;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
