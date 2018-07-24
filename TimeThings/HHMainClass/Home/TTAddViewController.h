//
//  TTAddViewController.h
//  TimeThings
//
//  Created by caohouhong on 2018/7/21.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^finishBlock)();
@interface TTAddViewController : UIViewController
@property (nonatomic, copy) finishBlock block;
@end
