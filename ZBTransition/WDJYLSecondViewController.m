//
//  WDJYLSecondViewController.m
//  ZBTransition
//
//  Created by WuZhengBin on 16/2/17.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import "WDJYLSecondViewController.h"
#import "PureLayout.h"

@interface WDJYLSecondViewController ()

@end

@implementation WDJYLSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:1 green:0.9 blue:0.9 alpha:1];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];
    
    [button setTitle:@"Dismiss" forState:UIControlStateNormal];
    [button autoCenterInSuperview];
    
    [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonDidClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
