//
//  TTShowViewController.h
//  TimeThings
//
//  Created by caohouhong on 2018/7/23.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTListModel.h"
typedef void(^updateBlock)(void);
typedef void(^deleteBlock)(void);
@interface TTShowViewController : UIViewController
@property (nonatomic, copy) updateBlock updateblock;
@property (nonatomic, copy) deleteBlock deleteblock;
@property (nonatomic, strong) TTListModel *model;
@end
