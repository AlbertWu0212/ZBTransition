//
//  WDJYLFirstViewController.m
//  ZBTransition
//
//  Created by WuZhengBin on 16/2/17.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import "WDJYLFirstViewController.h"
#import "PureLayout.h"
#import "WDJYLSecondViewController.h"
#import "WDJYLAnimator.h"

@interface WDJYLFirstViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation WDJYLFirstViewController

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
    WDJYLSecondViewController *vc = [[WDJYLSecondViewController alloc] init];
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
    navc.modalPresentationStyle = UIModalPresentationCustom;
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
    return [WDJYLAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [WDJYLAnimator new];
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
