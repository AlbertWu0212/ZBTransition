//
//  WDJYLDismissAnimator.m
//  ZBTransition
//
//  Created by WuZhengBin on 16/2/17.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import "WDJYLDismissAnimator.h"

@implementation WDJYLDismissAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    
    UIView *fromView;
    UIView *toView;
}

@end
