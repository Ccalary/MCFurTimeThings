//
//  DataBase.m
//  FMDBDemo
//
//  Created by Zeno on 16/5/18.
//  Copyright © 2016年 zenoV. All rights reserved.
//

#import "LEIDataBase.h"
#import "FMDB.h"
#import "TTListModel.h"
#import "TTOrder.h"

static LEIDataBase *_DBCtl = nil;

@interface LEIDataBase()<NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
}

@end

@implementation LEIDataBase

+(instancetype)sharedDataBase{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [[LEIDataBase alloc] init];
        
        [_DBCtl initDataBase];
        
    }
    
    return _DBCtl;
    
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [super allocWithZone:zone];
        
    }
    
    return _DBCtl;
    
}

-(id)copy{
    
    return self;
    
}

-(id)mutableCopy{
    
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    
    return self;
    
}


-(void)initDataBase{
    // 获得Documents目录路径
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.sqlite"];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    [_db open];
    
    NSString *recordSql = @"CREATE TABLE IF NOT EXISTS 'listModel' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'r_id' VARCHAR(255),'title' VARCHAR(255), 'things' VARCHAR(255), 'colorType' VARCHAR(255), 'dateStr' VARCHAR(255),'timeStr' VARCHAR(255),'timestamp' VARCHAR(255))";
    
     NSString *clockSql = @"CREATE TABLE IF NOT EXISTS 'orderModel' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'r_id' VARCHAR(255),'content' VARCHAR(255),'creatTime' VARCHAR(255), 'is_on' VARCHAR(255), 'timestamp' VARCHAR(255))";
    
    [_db executeUpdate:recordSql];
    [_db executeUpdate:clockSql];
    [_db close];
}
#pragma mark - TTListModel
- (void)addListModel:(TTListModel *)listModel{
    [_db open];
    
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM listModel"];
    //获取数据库中最大的ID
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"r_id"] integerValue]) {
            maxID = @([[res stringForColumn:@"r_id"] integerValue] ) ;
        }
    }
    maxID = @([maxID integerValue] + 1);
    
    [_db executeUpdate:@"INSERT INTO listModel (r_id,title,things,colorType,dateStr,timeStr,timestamp) VALUES (?,?,?,?,?,?,?)",
     maxID,listModel.title,listModel.things,listModel.colorType,listModel.dateStr,listModel.timeStr,listModel.timestamp];
    
    [_db close];
}

- (NSMutableArray *)getAllModel{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM listModel ORDER BY timestamp DESC"];
    
    while ([res next]) {
        TTListModel *model = [[TTListModel alloc] init];
        model.r_id = @([[res stringForColumn:@"r_id"] integerValue]);
        model.title = [res stringForColumn:@"title"];
        model.things = [res stringForColumn:@"things"];
        model.colorType = @([[res stringForColumn:@"colorType"] integerValue]);
        model.dateStr = [res stringForColumn:@"dateStr"];
        model.timeStr = [res stringForColumn:@"timeStr"];
        model.timestamp = [res stringForColumn:@"timestamp"];
        [dataArray addObject:model];
    }
    [_db close];
    
    return dataArray;
}

- (void)deleteModel:(TTListModel *)model{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM listModel WHERE r_id = ?",model.r_id];
    [_db close];
}

- (void)updateModel:(TTListModel *)model {
    [_db open];
    NSString *sql = @"UPDATE listModel SET title = ? , things = ? WHERE r_id = ?";
    BOOL res = [_db executeUpdate:sql,model.title,model.things,model.r_id];
    if (!res) {
        NSLog(@"数据修改失败");
    } else {
        NSLog(@"数据修改成功");
    }
    [_db close];
}

- (NSMutableArray *)getListModelWithDate:(NSString *)dateStr{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    FMResultSet *res;
    res = [_db executeQuery:@"SELECT * FROM listModel WHERE dateStr = ?",dateStr];
    
    while ([res next]) {
        TTListModel *model = [[TTListModel alloc] init];
        model.r_id = @([[res stringForColumn:@"r_id"] integerValue]);
        model.title = [res stringForColumn:@"title"];
        model.things = [res stringForColumn:@"things"];
        model.colorType = @([[res stringForColumn:@"colorType"] integerValue]);
        model.dateStr = [res stringForColumn:@"dateStr"];
        model.timeStr = [res stringForColumn:@"timeStr"];
        model.timestamp = [res stringForColumn:@"timestamp"];
        [dataArray addObject:model];
    }
    [_db close];
    
    return dataArray;
}

// Order
- (void)addOrderModel:(TTOrder *)orderModel{
    [_db open];
    
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM orderModel"];
    //获取数据库中最大的ID
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"r_id"] integerValue]) {
            maxID = @([[res stringForColumn:@"r_id"] integerValue] ) ;
        }
    }
    maxID = @([maxID integerValue] + 1);
    
    [_db executeUpdate:@"INSERT INTO orderModel (r_id,content,creatTime,is_on,timestamp) VALUES (?,?,?,?,?)",maxID,orderModel.content,orderModel.creatTime,orderModel.is_on,orderModel.timestamp];
    [_db close];
}

- (NSMutableArray *)getAllOrder{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM orderModel"];
    
    while ([res next]) {
        TTOrder *model = [[TTOrder alloc] init];
        model.r_id = @([[res stringForColumn:@"r_id"] integerValue]);
        model.content = [res stringForColumn:@"content"];
        model.creatTime = [res stringForColumn:@"creatTime"];
        model.is_on = [res stringForColumn:@"is_on"];
        model.timestamp = [res stringForColumn:@"timestamp"];
        [dataArray addObject:model];
    }
    [_db close];
    
    return dataArray;
}

- (void)deleteOrder:(TTOrder *)model{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM orderModel WHERE r_id = ?",model.r_id];
    [_db close];
}

@end
