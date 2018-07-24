//
//  TTNothingView.h
//  TimeThings
//
//  Created by caohouhong on 2018/7/23.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTNothingView : UIView
- (instancetype)initWithFrame:(CGRect)frame addAction:(void(^)(void))block;
@end
