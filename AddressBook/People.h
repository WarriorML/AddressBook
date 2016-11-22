//
//  People.h
//  AddressBook
//
//  Created by MengLong Wu on 2016/11/22.
//  Copyright © 2016年 MengLong Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject

@property (nonatomic,copy)NSString *name;

@property (nonatomic,assign)NSInteger peopleID;


+ (People *)createContactWithName:(NSString *)name peopleID:(NSInteger)peopleID;

@end
