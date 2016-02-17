//
//  SwipeFirstViewController.m
//  ZBTransition
//
//  Created by WuZhengBin on 16/2/16.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import "SwipeFirstViewController.h"
#import "SwipeSecondViewController.h"
#import "SwipeAnimator.h"
#import "PureLayout.h"
#import "SwipeTransitionDelegate.h"

@interface SwipeFirstViewController ()
@property (nonatomic, strong) SwipeTransitionDelegate *customTransitionDelegate;
@end

@implementation SwipeFirstViewController

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
    
    UIScreenEdgePanGestureRecognizer *interactiveTransitionRecognizer;
    interactiveTransitionRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(interactiveTransitionRecognizerAction:)];
    interactiveTransitionRecognizer.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:interactiveTransitionRecognizer];
}

- (IBAction)interactiveTransitionRecognizerAction:(UIScreenEdgePanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self buttonDidClicked:sender];
    }
}

- (void)buttonDidClicked:(id)sender
{
    SwipeTransitionDelegate *transitionDelegate = self.customTransitionDelegate;
    if ([sender isKindOfClass:[UIGestureRecognizer class]]) {
        transitionDelegate.gestureRecognizer = sender;
    } else {
        transitionDelegate.gestureRecognizer = nil;
    }
    
    SwipeSecondViewController *dvc = [[SwipeSecondViewController alloc] init];
    
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:dvc];
    
    transitionDelegate.targetEdge = UIRectEdgeRight;
    navc.transitioningDelegate = transitionDelegate;
    navc.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self.navigationController presentViewController:navc animated:YES completion:nil];
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
- (SwipeTransitionDelegate *)customTransitionDelegate
{
    if (_customTransitionDelegate == nil) {
        _customTransitionDelegate = [[SwipeTransitionDelegate alloc] init];
    }
    
    return _customTransitionDelegate;
}

@end
