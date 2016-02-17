//
//  SwipeTransitionInteractionController.h
//  ZBTransition
//
//  Created by WuZhengBin on 16/2/16.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeTransitionInteractionController : UIPercentDrivenInteractiveTransition

- (instancetype)initWithGestureRecognizer:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer
                          edgeForDragging:(UIRectEdge)edge NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end
