//
//  TTHeader.h
//  TimeThings
//
//  Created by caohouhong on 2018/7/21.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#ifndef TTHeader_h
#define TTHeader_h
//大小尺寸（宽、高）
#define TTScreenWidth                     [[UIScreen mainScreen] bounds].size.width
#define TTScreenHeight                    [[UIScreen mainScreen] bounds].size.height
//statusBar高度
#define TTStatusBarHeight                 [UIApplication sharedApplication].statusBarFrame.size.height
//navBar高度
#define TTNavigationBarHeight             [[UINavigationController alloc] init].navigationBar.frame.size.height
//TabBar高度  iPhoneX 高度为83
#define TTTabBarHeight                    ((TTStatusBarHeight > 20.0f) ? 83.0f : 49.0f)
//nav顶部高度
#define TTTopFullHeight                   (TTStatusBarHeight + TTNavigationBarHeight)

#endif /* TTHeader_h */
