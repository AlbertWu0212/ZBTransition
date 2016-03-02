//
//  WDJYLAnimator.m
//  ZBTransition
//
//  Created by WuZhengBin on 16/2/17.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import "WDJYLAnimator.h"

@implementation WDJYLAnimator

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
    
//    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
//        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
//    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
//    }
    
//    fromView.frame = [transitionContext initialFrameForViewController:fromViewController];
//    toView.frame = [transitionContext finalFrameForViewController:toViewController];
    
    [containerView addSubview:toView];
    
    fromView.alpha = 1.0;
    toView.alpha = 0.0;
    toView.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.9, 0.9, 1);
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:transitionDuration animations:^{
        
        [fromView.layer setTransform:CATransform3DScale(CATransform3DIdentity, 0.9, 0.9, 1)];
        
    } completion:^(BOOL finished) {
    
        [UIView animateWithDuration:transitionDuration animations:^{
            fromView.alpha = 0.0f;
            toView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:transitionDuration animations:^{
                [toView.layer setTransform:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 1)];
            } completion:^(BOOL finished) {

                
                BOOL wasCancelled = [transitionContext transitionWasCancelled];
                [transitionContext completeTransition:!wasCancelled];
                fromView.alpha = 1.0f;
            }];
            

        }];
        

        
    }];
}

@end
