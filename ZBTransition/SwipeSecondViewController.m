//
//  SwipeSecondViewController.m
//  ZBTransition
//
//  Created by WuZhengBin on 16/2/16.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import "SwipeSecondViewController.h"
#import "PureLayout.h"
#import "SwipeTransitionDelegate.h"

@interface SwipeSecondViewController ()

@end

@implementation SwipeSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:1 green:0.9 blue:0.9 alpha:1];
    self.navigationController.navigationBar.hidden = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];
    
    [button setTitle:@"Dismiss" forState:UIControlStateNormal];
    [button autoCenterInSuperview];
    
    [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIScreenEdgePanGestureRecognizer *interactiveTransitionRecognizer;
    interactiveTransitionRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(interactiveTransitionRecognizerAction:)];
    interactiveTransitionRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:interactiveTransitionRecognizer];
}

- (void)interactiveTransitionRecognizerAction:(UIScreenEdgePanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self buttonDidClicked:sender];
    }
}

- (void)buttonDidClicked:(id)sender
{
    if ([self.navigationController.transitioningDelegate isKindOfClass:[SwipeTransitionDelegate class]]) {
        SwipeTransitionDelegate *transitionDelegate = self.navigationController.transitioningDelegate;
        
        if ([sender isKindOfClass:[UIGestureRecognizer class]]) {
            transitionDelegate.gestureRecognizer = sender;
        } else {
            transitionDelegate.gestureRecognizer = nil;
        }
        
        transitionDelegate.targetEdge = UIRectEdgeLeft;
        self.navigationController.transitioningDelegate = transitionDelegate;
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
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
