//
//  DatabaseTool.m
//  AddressBook
//
//  Created by MengLong Wu on 2016/11/22.
//  Copyright © 2016年 MengLong Wu. All rights reserved.
//

#import "DatabaseTool.h"
#import "People.h"
FMDatabase *__db;

@implementation DatabaseTool

+ (void)openDatabaseAndCreateTable
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/database.sqlite"];
    
    __db = [[FMDatabase alloc]initWithPath:path];
    
    if ([__db open]) {
//        创建表
        NSString *sql = @"create table if not exists People(peopleID integer primary key autoincrement not null unique,name text)";
        
        [__db executeUpdate:sql];
        
        sql = @"create table if not exists Phone(peopleID integer not null,phone text)";
        
        [__db executeUpdate:sql];
    }
}

+ (NSArray *)getAllContact
{
    NSString *sql = @"select * from People";
    
    FMResultSet *set = [__db executeQuery:sql];
    
    NSMutableArray *array = [NSMutableArray array];
    
    while ([set next]) {
        NSString *name = [set stringForColumnIndex:1];
        
        NSInteger peopleID = [set intForColumnIndex:0];
        
        People *p = [People createContactWithName:name peopleID:peopleID];
        
        [array addObject:p];
    }
    
    [set close];
    
    return array;
}
+ (NSArray *)getAllPhoneWithPeopleID:(NSInteger)peopleID
{
    NSString *sql = [NSString stringWithFormat:@"select * from Phone where peopleID = %ld",peopleID];
    
    FMResultSet *set = [__db executeQuery:sql];
    
    NSMutableArray *array = [NSMutableArray array];
    
    while ([set next]) {
        NSString *phone = [set stringForColumnIndex:1];
        
        [array addObject:phone];
    }
    
    [set close];
    
    return array;
}
+ (NSInteger)insertContactWithName:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"insert into People (name) values ('%@')",name];
    
    [__db executeUpdate:sql];
    
    sql = @"select max(peopleID) from People";
    
    FMResultSet *set = [__db executeQuery:sql];
    
    [set next];
    
    NSInteger peopleID = [set intForColumnIndex:0];
    
    [set close];
    
    return peopleID;
}
+ (void)insertPhoneWithPeopleID:(NSInteger)peopleID phone:(NSString *)phone
{
    NSString *sql = [NSString stringWithFormat:@"insert into Phone (peopleID,phone) values (%ld,'%@')",peopleID,phone];
    
    [__db executeUpdate:sql];
}



@end
