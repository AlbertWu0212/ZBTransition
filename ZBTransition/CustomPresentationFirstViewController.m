//
//  CustomPresentationFirstViewController.m
//  ZBTransition
//
//  Created by WuZhengBin on 16/2/16.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import "CustomPresentationFirstViewController.h"
#import "CustomPresentationSecondViewController.h"
#import "PureLayout.h"
#import "CustomPresentationController.h"

@interface CustomPresentationFirstViewController ()

@end

@implementation CustomPresentationFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:1 alpha:1];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];
    
    [button setTitle:@"Present With Custom Transition" forState:UIControlStateNormal];
    [button autoCenterInSuperview];
    
    [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonDidClicked:(id)sender
{
    CustomPresentationSecondViewController *vc = [[CustomPresentationSecondViewController alloc] init];
    CustomPresentationController *presentationController = [[CustomPresentationController alloc] initWithPresentedViewController:vc
                                                                                                        presentingViewController:self];
    
//    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.transitioningDelegate = presentationController;
    
//    vc.transitioningDelegate = presentationController;
//    navc.transitioningDelegate = presentationController;
    [self.navigationController presentViewController:vc animated:YES completion:NULL];
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
