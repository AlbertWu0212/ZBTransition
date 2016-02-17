//
//  SwipeAnimator.h
//  ZBTransition
//
//  Created by WuZhengBin on 16/2/16.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface SwipeAnimator : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge;
@property (nonatomic, readwrite) UIRectEdge targetEdge;

@end
