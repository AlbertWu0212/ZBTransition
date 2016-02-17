//
//  SwipeTransitionDelegate.m
//  ZBTransition
//
//  Created by WuZhengBin on 16/2/16.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import "SwipeTransitionDelegate.h"
#import "SwipeAnimator.h"
#import "SwipeTransitionInteractionController.h"

@implementation SwipeTransitionDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[SwipeAnimator alloc] initWithTargetEdge:self.targetEdge];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[SwipeAnimator alloc] initWithTargetEdge:self.targetEdge];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    if (self.gestureRecognizer)
        return [[SwipeTransitionInteractionController alloc] initWithGestureRecognizer:self.gestureRecognizer edgeForDragging:self.targetEdge];
    else
        return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    if (self.gestureRecognizer)
        return [[SwipeTransitionInteractionController alloc] initWithGestureRecognizer:self.gestureRecognizer edgeForDragging:self.targetEdge];
    else
        return nil;
}

@end
