//
//  SwipeAnimator.m
//  ZBTransition
//
//  Created by WuZhengBin on 16/2/16.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import "SwipeAnimator.h"

@implementation SwipeAnimator

- (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge
{
    self = [super init];
    if (self) {
        _targetEdge = targetEdge;
    }
    return self;
}

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
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    BOOL isPresenting = (toViewController.presentingViewController == fromViewController);
    
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    
    CGVector offset;
    if (self.targetEdge == UIRectEdgeTop) {
        offset = CGVectorMake(0.0f, 1.0f);
    } else if (self.targetEdge == UIRectEdgeBottom) {
        offset = CGVectorMake(0.0f, -1.0f);
    } else if (self.targetEdge == UIRectEdgeLeft) {
        offset = CGVectorMake(1.0f, 0.0f);
    } else if (self.targetEdge == UIRectEdgeRight) {
        offset = CGVectorMake(-1.0f, 0.0f);
    } else {
        NSAssert(NO, @"targetEdge must not be nil");
    }
    
    if (isPresenting) {
        fromView.frame = fromFrame;
        toView.frame = CGRectOffset(toFrame, toFrame.size.width * offset.dx * -1, toFrame.size.height * offset.dy * -1);
    } else {
        fromView.frame = fromFrame;
        toView.frame = toFrame;
    }
    
    if (isPresenting)
        [containerView addSubview:toView];
    else
        [containerView insertSubview:toView belowSubview:fromView];
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:transitionDuration animations:^{
        if (isPresenting) {
            toView.frame = toFrame;
        } else {
            fromView.frame = CGRectOffset(fromFrame, fromFrame.size.width * offset.dx, fromFrame.size.height * offset.dy);
        }
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        
        if (wasCancelled) {
            [toView removeFromSuperview];
        }
        
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end
