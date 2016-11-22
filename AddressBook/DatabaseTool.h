//
//  DatabaseTool.h
//  AddressBook
//
//  Created by MengLong Wu on 2016/11/22.
//  Copyright © 2016年 MengLong Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface DatabaseTool : NSObject

//打开数据库并创建表
+ (void)openDatabaseAndCreateTable;

+ (NSArray *)getAllContact;

+ (NSArray *)getAllPhoneWithPeopleID:(NSInteger)peopleID;

+ (NSInteger)insertContactWithName:(NSString *)name;


+ (void)insertPhoneWithPeopleID:(NSInteger)peopleID phone:(NSString *)phone;

@end
