//
//  MainTableViewController.m
//  ZBTransition
//
//  Created by WuZhengBin on 16/2/16.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import "MainTableViewController.h"
#import "CrossDissolveFirstViewController.h"
#import "SwipeFirstViewController.h"
#import "CustomPresentationFirstViewController.h"

static NSString * const CELL_IDENTIFIER = @"cell";
static NSString * const KEY_TITLE       = @"title";
static NSString * const KEY_SUBTITLE    = @"subTitle";
static NSString * const KEY_CLASSNAME   = @"className";

@interface MainTableViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CustomTransition";
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER];
    
    [self setupDataSource];
}

- (void)setupDataSource
{
    NSMutableArray *tempArray = [NSMutableArray array];
    NSDictionary *dic1 = @{KEY_TITLE:@"Cross Dissolve",
                           KEY_SUBTITLE:@"A cross dissolve transition",
                           KEY_CLASSNAME:NSStringFromClass([CrossDissolveFirstViewController class])};
    [tempArray addObject:dic1];
    
    NSDictionary *dic2 = @{KEY_TITLE:@"Swipe",
                           KEY_SUBTITLE:@"An interactive transition",
                           KEY_CLASSNAME:NSStringFromClass([SwipeFirstViewController class])};
    [tempArray addObject:dic2];
    
    NSDictionary *dic3 = @{KEY_TITLE:@"Custom Presentation",
                           KEY_SUBTITLE:@"Using a presentation controller",
                           KEY_CLASSNAME:NSStringFromClass([CustomPresentationFirstViewController class])};
    [tempArray addObject:dic3];
    
    self.dataSource = [NSArray arrayWithArray:tempArray];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = nil;
    // Configure the cell...
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELL_IDENTIFIER];
    }
    cell.textLabel.text = dic[KEY_TITLE];
    cell.detailTextLabel.text = dic[KEY_SUBTITLE];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = indexPath.row;
    NSDictionary *dic = [self.dataSource objectAtIndex:row];
    
    NSString *className = dic[KEY_CLASSNAME];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *vc = class.new;
        vc.title = dic[KEY_TITLE];
        vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain
                                                                              target:self action:@selector(dismiss)];
        UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:navc animated:YES completion:NULL];
    }
}

- (void)dismiss
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
