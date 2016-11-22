//
//  People.m
//  AddressBook
//
//  Created by MengLong Wu on 2016/11/22.
//  Copyright © 2016年 MengLong Wu. All rights reserved.
//

#import "People.h"

@implementation People

- (id)initWithName:(NSString *)name peopleID:(NSInteger)peopleID
{
    self = [super init];
    if (self) {
        _name = name;
        _peopleID = peopleID;
    }
    return self;
}

//工厂模式
+ (People *)createContactWithName:(NSString *)name peopleID:(NSInteger)peopleID
{
    return [[[self alloc]initWithName:name peopleID:peopleID] autorelease];
}

- (void)dealloc
{
    [_name release];
    [super dealloc];
}

@end
