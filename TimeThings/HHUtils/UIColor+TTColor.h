//
//  UIColor+TTColor.h
//  TimeThings
//
//  Created by caohouhong on 2018/7/21.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TTColor)
//MARK:- Theme
+ (UIColor *)tt_themeColor;
//MARK:- Method
+ (UIColor *)tt_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)tt_colorWithHex:(NSInteger)hexValue;
+ (UIColor*)tt_randomColor;
@end
