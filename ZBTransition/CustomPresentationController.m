//
//  CustomPresentationController.m
//  ZBTransition
//
//  Created by WuZhengBin on 16/2/16.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import "CustomPresentationController.h"

@interface CustomPresentationController () <UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) UIView *dimmingView;
@property (nonatomic, strong) UIView *presentationWrappingView;
@end

@implementation CustomPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (UIView *)presentedView
{
    return self.presentationWrappingView;
}

- (void)presentationTransitionWillBegin
{
    UIView *presentedViewControllerView = [super presentedView];
    
    {
        UIView *presentationWrapperView = [[UIView alloc] initWithFrame:self.frameOfPresentedViewInContainerView];
        presentationWrapperView.layer.shadowOpacity = 0.44f;
        presentationWrapperView.layer.shadowRadius = 13.0f;
        presentationWrapperView.layer.shadowOffset = CGSizeMake(0, -6.0f);
        self.presentationWrappingView = presentationWrapperView;
        
        UIView *presentationRoundedCornerView = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(presentationWrapperView.bounds, UIEdgeInsetsMake(0, 0, 0, 0))];
        presentationRoundedCornerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        presentationRoundedCornerView.layer.cornerRadius = 0;
        presentationRoundedCornerView.layer.masksToBounds = YES;
        
        // To undo the extra height added to presentationRoundedCornerView,
        // presentedViewControllerWrapperView is inset by CORNER_RADIUS points.
        // This also matches the size of presentedViewControllerWrapperView's
        // bounds to the size of -frameOfPresentedViewInContainerView.
        UIView *presentedViewControllerWrapperView = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(presentationRoundedCornerView.bounds, UIEdgeInsetsMake(0, 0, 0, 0))];
        presentedViewControllerWrapperView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        // Add presentedViewControllerView -> presentedViewControllerWrapperView.
        presentedViewControllerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        presentedViewControllerView.frame = presentedViewControllerWrapperView.bounds;
        [presentedViewControllerWrapperView addSubview:presentedViewControllerView];
        
        // Add presentedViewControllerWrapperView -> presentationRoundedCornerView.
        [presentationRoundedCornerView addSubview:presentedViewControllerWrapperView];
        
        // Add presentationRoundedCornerView -> presentationWrapperView.
        [presentationWrapperView addSubview:presentationRoundedCornerView];
    }
    
    {
        UIView *dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
        dimmingView.backgroundColor = [UIColor blackColor];
        dimmingView.opaque = NO;
        dimmingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)]];
        self.dimmingView = dimmingView;
        [self.containerView addSubview:dimmingView];
        
        // Get the transition coordinator for the presentation so we can
        // fade in the dimmingView alongside the presentation animation.
        id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
        
        self.dimmingView.alpha = 0.f;
        [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            self.dimmingView.alpha = 0.5f;
        } completion:NULL];
    }
}

- (void)presentationTransitionDidEnd:(BOOL)completed
{
    if (completed == NO) {
        self.presentationWrappingView = nil;
        self.dimmingView = nil;
    }
}

- (void)dismissalTransitionWillBegin
{
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.0f;
    } completion:NULL];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (completed == YES) {
        self.presentationWrappingView = nil;
        self.dimmingView = nil;
    }
}

#pragma mark 
#pragma mark Layout
- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container
{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    
    if (container == self.presentedViewController) {
        [self.containerView setNeedsLayout];
    }
}

- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize
{
    if (container == self.presentedViewController) {
        return ((UIViewController *)container).preferredContentSize;
    } else {
        return [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
    }
}

- (CGRect)frameOfPresentedViewInContainerView
{
    CGRect containerViewBounds = self.containerView.bounds;
    CGSize presentedViewContentSize = [self sizeForChildContentContainer:self.presentedViewController
                                                 withParentContainerSize:containerViewBounds.size];
    
    CGRect presentedViewControllerFrame = containerViewBounds;
    presentedViewControllerFrame.size.height = presentedViewContentSize.height;
    presentedViewControllerFrame.origin.y = CGRectGetMaxY(containerViewBounds) - presentedViewContentSize.height;
    return presentedViewControllerFrame;
}

- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    
    self.dimmingView.frame = self.containerView.bounds;
    self.presentationWrappingView.frame = self.frameOfPresentedViewInContainerView;
}

#pragma mark -
#pragma mark Tap Gesture Recognizer

- (void)dimmingViewTapped:(UITapGestureRecognizer*)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - 
#pragma mark UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return [transitionContext isAnimated] ? 0.35 : 0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    BOOL isPresenting = (fromViewController == self.presentingViewController);
    
    CGRect __unused fromViewInitialFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect fromViewFinalFrame = [transitionContext finalFrameForViewController:fromViewController];
    CGRect toViewInitialFrame = [transitionContext initialFrameForViewController:toViewController];
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toViewController];
    
    [containerView addSubview:toView];
    
    
    if (isPresenting) {
        toViewInitialFrame.origin = CGPointMake(CGRectGetMinX(containerView.bounds), CGRectGetMaxY(containerView.bounds));
        toViewInitialFrame.size = toViewFinalFrame.size;
        toView.frame = toViewInitialFrame;
        
        fromView = fromViewController.view;
    } else {
        fromViewFinalFrame = CGRectOffset(fromView.frame, 0, CGRectGetHeight(fromView.frame));
        
        toView = toViewController.view;
    }
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:transitionDuration animations:^{
        if (isPresenting) {
            toView.frame = toViewFinalFrame;
//            fromView.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.9f, 0.9f, 1.0f);
            [fromView.layer setTransform:[self firstTransform]];
        } else {
            
            fromView.frame = fromViewFinalFrame;
//            toView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.0f, 1.0f, 1.0f);
            [toView.layer setTransform:[self reverseFirstTransform]];
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:transitionDuration animations:^{
            if (isPresenting) {
               [fromView.layer setTransform:[self secondTransform]];
            } else {
               [toView.layer setTransform:[self reverseSecondTransform]];
            }
        }];
        
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

#pragma mark - 
#pragma mark TransForm
- (CATransform3D)firstTransform
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0/ -900;
    //---宽高缩小0.9
    transform = CATransform3DScale(transform, 0.95, 0.95, 1);
    //---绕X轴旋转15度
    transform = CATransform3DRotate(transform, 15.0 * M_PI / 180.0 , 1, 0, 0);
    
    return transform;
}

- (CATransform3D )secondTransform
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = [self firstTransform].m34;
    //---向上移动的高度
    transform = CATransform3DTranslate(transform, 0, -20 , 0);
    //---宽高缩小0.8
    transform = CATransform3DScale(transform, 0.8, 0.8, 1);
    
    return transform;
}

#pragma mark -
#pragma mark Reverse
- (CATransform3D)reverseFirstTransform
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / -900;
//    transform.m34 = [self firstTransform].m34;
    transform = CATransform3DRotate(transform, 15 * M_PI / 180.0 , 1, 0, 0);
   transform = CATransform3DScale(transform, 0.95, 0.95, 1);

    return transform;
}

- (CATransform3D)reverseSecondTransform
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = [self reverseFirstTransform].m34;

    
    transform = CATransform3DTranslate(transform, 0, 0, 0);
    transform = CATransform3DScale(transform, 1, 1, 1);
    
    return transform;
}

#pragma mark - 
#pragma mark UIViewControllerTransitioningDelegate
- (UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    NSAssert(self.presentedViewController == presented,
             @"You didn't initialize %@ with the correct presentedViewController.  Expected %@, got %@.",
             self, presented, self.presentedViewController);
    
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}

@end
