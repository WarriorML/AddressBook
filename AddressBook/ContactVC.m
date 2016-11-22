//
//  ContactVC.m
//  AddressBook
//
//  Created by MengLong Wu on 2016/11/22.
//  Copyright © 2016年 MengLong Wu. All rights reserved.
//

#import "ContactVC.h"
#import "DatabaseTool.h"
@interface ContactVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_phoneArray;
    IBOutlet UITableView *_phoneTable;
    IBOutlet UITextField *_phoneField;
    IBOutlet UITextField *_nameField;
}
@end

@implementation ContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _phoneArray = [[NSMutableArray alloc]init];
    
    if (!_person) {
        
    }else{
//        存在
        _nameField.text = _person.name;
        _nameField.enabled = NO;
//        获取这个人对应的所有电话号
        [_phoneArray setArray:[DatabaseTool getAllPhoneWithPeopleID:_person.peopleID]];
    }
    
    _phoneTable.delegate = self;
    _phoneTable.dataSource = self;
    
    [_phoneTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}
- (IBAction)addContact:(id)sender {
    
    if (_nameField.text.length <= 0) {
        return;
    }
    if (_phoneField.text.length <= 0) {
        return;
    }
    
    [_phoneArray addObject:_phoneField.text];
    
    [_phoneTable reloadData];
    
    if (_person) {
        
    }else{
        //        不存在
        NSInteger peopleID = [DatabaseTool insertContactWithName:_nameField.text];
        
        _person = [[People alloc]init];
        
        _person.name = _nameField.text;
        
        _person.peopleID = peopleID;
    }
    
//    插入电话号
    [DatabaseTool insertPhoneWithPeopleID:_person.peopleID phone:_phoneField.text];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _phoneArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = _phoneArray[indexPath.row];
    
    return cell;
}
- (void)dealloc {
    [_phoneArray release];
    [_nameField release];
    [_phoneField release];
    [_phoneTable release];
    [_person release];
    [super dealloc];
}
@end
