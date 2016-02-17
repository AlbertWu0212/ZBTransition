//
//  CrossDissolveFirstViewController.m
//  ZBTransition
//
//  Created by WuZhengBin on 16/2/16.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import "CrossDissolveFirstViewController.h"
#import "CrossDissolveSecondViewController.h"
#import "CrossDissolveTransitionAnimator.h"
#import "PureLayout.h"

@interface CrossDissolveFirstViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation CrossDissolveFirstViewController

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
    CrossDissolveSecondViewController *vc = [[CrossDissolveSecondViewController alloc] init];
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
    navc.modalPresentationStyle = UIModalPresentationFullScreen;
    navc.transitioningDelegate = self;
    [self presentViewController:navc animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [CrossDissolveTransitionAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [CrossDissolveTransitionAnimator new];
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
