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
#import "MainNavigationController.h"
#import "CustomPresentationFirstViewController.h"

static NSString * const CELL_IDENTIFIER = @"cell";

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
    NSDictionary *dic1 = @{@"title":@"Cross Dissolve",
                          @"subTitle":@"A cross dissolve transition"};
    [tempArray addObject:dic1];
    
    NSDictionary *dic2 = @{@"title":@"Swipe",
                           @"subTitle":@"An interactive transition"};
    [tempArray addObject:dic2];
    
    NSDictionary *dic3 = @{@"title":@"Custom Presentation",
                           @"subTitle":@"Using a presentation controller"};
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
    cell.textLabel.text = dic[@"title"];
    cell.detailTextLabel.text = dic[@"subTitle"];
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
    
    if (row == 0) {
        CrossDissolveFirstViewController *vc = [[CrossDissolveFirstViewController alloc] init];
        vc.title = dic[@"title"];
        vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self action:@selector(dismiss)];
        MainNavigationController *navc = [[MainNavigationController alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:navc animated:YES completion:nil];
    }
    
    if (row == 1) {
        SwipeFirstViewController *vc = [[SwipeFirstViewController alloc] init];
        vc.title = dic[@"title"];
        vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self action:@selector(dismiss)];
        MainNavigationController *navc = [[MainNavigationController alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:navc animated:YES completion:nil];
    }
    
    if (row == 2) {
        CustomPresentationFirstViewController *vc = [[CustomPresentationFirstViewController alloc] init];
        vc.title = dic[@"title"];
        vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self action:@selector(dismiss)];
        MainNavigationController *navc = [[MainNavigationController alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:navc animated:YES completion:nil];
    }
}

- (void)dismiss
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
