//
//  SwipeTransitionDelegate.h
//  ZBTransition
//
//  Created by WuZhengBin on 16/2/16.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface SwipeTransitionDelegate : NSObject <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *gestureRecognizer;
@property (nonatomic, readwrite) UIRectEdge targetEdge;
@end
