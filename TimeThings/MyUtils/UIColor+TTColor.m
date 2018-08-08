//
//  UIColor+TTColor.m
//  TimeThings
//
//  Created by caohouhong on 2018/7/21.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "UIColor+TTColor.h"

@implementation UIColor (TTColor)
//MARK:- Theme
+ (UIColor *)tt_themeColor{
    return [UIColor tt_colorWithHex:0x54D888];
}

//MARK:- Method
+ (UIColor *)tt_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alpha];
}

+ (UIColor *)tt_colorWithHex:(NSInteger)hexValue
{
    return [UIColor tt_colorWithHex:hexValue alpha:1.0];
}

+ (UIColor*)tt_randomColor
{
    return [UIColor colorWithRed:(arc4random()%255)*1.0f/255.0
                           green:(arc4random()%255)*1.0f/255.0
                            blue:(arc4random()%255)*1.0f/255.0 alpha:1.0];
}
@end
