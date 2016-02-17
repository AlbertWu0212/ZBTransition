//
//  CrossDissolveSecondViewController.m
//  ZBTransition
//
//  Created by WuZhengBin on 16/2/16.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import "CrossDissolveSecondViewController.h"
#import "PureLayout.h"

@interface CrossDissolveSecondViewController ()

@end

@implementation CrossDissolveSecondViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
