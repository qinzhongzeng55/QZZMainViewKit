//
//  QZZDBManager.m
//
//
//  Created by qinzhongzeng on 16/4/5.
//  Copyright © 2016年 Triangle. All rights reserved.
//

#import "QZZDBManager.h"
#import <fmdb/FMDatabase.h>
#import <fmdb/FMResultSet.h>

NSString * const kDBName = @"db.sqlite";

static FMDatabase *_db;

@interface QZZDBManager ()

@property (nonatomic, copy) NSDictionary *whiteList;

@end

@implementation QZZDBManager

+ (instancetype)sharedManager {
    
    static QZZDBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[QZZDBManager alloc] init];
    });
    return manager;
}

+ (void)initialize {
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqliteFile = [documentPath stringByAppendingPathComponent:kDBName];
    _db = [FMDatabase databaseWithPath:sqliteFile];
    _db.traceExecution = YES;

}

#pragma mark - create 'Table'
- (void)createTable {
    
    if (![_db open]) {
        return;
    }

    BOOL isSuccess = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS T_CACHE (id INTEGER PRIMARY KEY AUTOINCREMENT,cache_data blob not null,cache_key text)"];
    if (isSuccess) {
        NSLog(@"---------------------");
        NSLog(@" create table success");
        NSLog(@"---------------------");
    }else{
        NSLog(@"-------------------");
        NSLog(@" create table faild");
        NSLog(@"-------------------");
    }
}

#pragma mark - insert data
- (void)insertItem:(id)item cacheKey:(NSString *)cacheKey {
    
    if (![_db open]) {
        return;
    }
    NSData *cacheData = [NSKeyedArchiver archivedDataWithRootObject:item];
    BOOL isSuccess = [_db executeUpdateWithFormat:@"INSERT INTO T_CACHE (cache_data,cache_key) VALUES (%@,%@)",cacheData,cacheKey];
    if (isSuccess) {
        NSLog(@"---------------");
        NSLog(@" insert success");
        NSLog(@"---------------");
    }else{
        NSLog(@"-------------");
        NSLog(@" insert faild");
        NSLog(@"-------------");
    }
}

- (id)itemWithCacheKey:(NSString *)cacheKey {
    
    if (![_db open] || !cacheKey) {
        return nil;
    }
    FMResultSet *rs = [_db executeQueryWithFormat:@"SELECT * FROM T_CACHE WHERE cache_key = %@",cacheKey];
    while ([rs next]) {
        NSData *data = [rs dataForColumn:@"cache_data"];
        id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return obj;
    }
    return nil;
}

#pragma mark - clear all data
- (void)clearAll {
    
    [_db executeUpdate:@"DELETE FROM T_CACHE"];
}

- (NSString *)getDBPath {
    
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *dbPath = [documentPath stringByAppendingPathComponent:kDBName];
    return dbPath;
}

@end
