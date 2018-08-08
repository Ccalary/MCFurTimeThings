//
//  DataBase.h
//  FMDBDemo
//
//  Created by Zeno on 16/5/18.
//  Copyright © 2016年 zenoV. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TTListModel;
@class TTOrder;

@interface LEIDataBase : NSObject

@property (nonatomic, strong) TTListModel *listModel;

+ (instancetype)sharedDataBase;

#pragma mark - Record
- (void)addListModel:(TTListModel *)listModel;
- (void)deleteModel:(TTListModel *)model;
- (NSMutableArray *)getAllModel;
- (void)updateModel:(TTListModel *)model;
// 日期种类查找
- (NSMutableArray *)getListModelWithDate:(NSString *)dateStr;

// 添加闹钟
- (void)addOrderModel:(TTOrder *)orderModel;
- (NSMutableArray *)getAllOrder;
- (void)deleteOrder:(TTOrder *)model;
@end
