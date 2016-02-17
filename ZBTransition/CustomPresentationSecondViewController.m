//
//  CustomPresentationSecondViewController.m
//  ZBTransition
//
//  Created by WuZhengBin on 16/2/16.
//  Copyright © 2016年 WuZhengBin. All rights reserved.
//

#import "CustomPresentationSecondViewController.h"
#import "PureLayout.h"

@interface CustomPresentationSecondViewController ()

@end

@implementation CustomPresentationSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:1 green:0.9 blue:0.9 alpha:1];
    self.navigationController.navigationBar.hidden = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];
    
    [button setTitle:@"dismiss" forState:UIControlStateNormal];
    [button autoCenterInSuperview];
    
    [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self updatePreferredContentSizeWithTraitCollection:self.traitCollection];
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    
    // When the current trait collection changes (e.g. the device rotates),
    // update the preferredContentSize.
    [self updatePreferredContentSizeWithTraitCollection:newCollection];
}

- (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection
{
    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width,
                                           traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ? 270 : 420);
    
    // To demonstrate how a presentation controller can dynamically respond
    // to changes to its presented view controller's preferredContentSize,
    // this view controller exposes a slider.  Dragging this slider updates
    // the preferredContentSize of this view controller in real time.
    //
    // Update the slider with appropriate min/max values and reset the
    // current value to reflect the changed preferredContentSize.
//    self.slider.maximumValue = self.preferredContentSize.height;
//    self.slider.minimumValue = 220.f;
//    self.slider.value = self.slider.maximumValue;
}

- (void)buttonDidClicked:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    [self dismissViewControllerAnimated:YES completion:NULL];
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
