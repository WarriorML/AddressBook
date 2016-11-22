//
//  ViewController.m
//  AddressBook
//
//  Created by MengLong Wu on 2016/11/22.
//  Copyright © 2016年 MengLong Wu. All rights reserved.
//

#import "ViewController.h"
#import "People.h"
#import "ContactVC.h"
#import "DatabaseTool.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain)NSMutableArray *contactArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@",NSHomeDirectory());
    [DatabaseTool openDatabaseAndCreateTable];
    
    _contactArray = [[NSMutableArray alloc]init];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 50;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getContact];
}
- (void)getContact
{
    [_contactArray setArray:[DatabaseTool getAllContact]];
    
    [_tableView reloadData];
}
#pragma mark 添加删除联系人
- (IBAction)addContact:(id)sender {
    
    ContactVC *cvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"abc"];
    
    [self.navigationController pushViewController:cvc animated:YES];
    
}


- (IBAction)deleteContact:(id)sender {
}

#pragma mark UITableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _contactArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    People *p = [_contactArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = p.name;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactVC *cvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"abc"];
    
    People *p = [_contactArray objectAtIndex:indexPath.row];
    
    cvc.person = p;
    
    [self.navigationController pushViewController:cvc animated:YES];
}

- (void)dealloc {
    [_tableView release];
    [_contactArray release];
    [super dealloc];
}
@end
