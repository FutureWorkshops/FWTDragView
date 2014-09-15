//
//  FWTViewController.m
//  FWTDragView
//
//  Created by Tim Chilvers on 09/08/2014.
//  Copyright (c) 2014 Tim Chilvers. All rights reserved.
//

#import "FWTViewController.h"
#import "FWTDragView.h"
#import "FWTLateralDismissCriteria.h"

@interface FWTViewController ()

@property (nonatomic,strong) FWTDragView *dragView;
@end

@implementation FWTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dragView = [FWTDragView dragViewWithDismissCriteria:@[[FWTLateralDismissCriteria lateralCriteriaWithStart:20.f end:80.f target:200.f],[FWTLateralDismissCriteria lateralCriteriaWithStart:-20.f end:-80.f target:-200.f]]];
    self.dragView.frame = (CGRect){{100.f,100.f},{120.f,200.f}};
    self.dragView.dismissAnimationDuration = 0.1f;
    self.dragView.centerAnimationDuration = 0.1f;
    self.dragView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.dragView];
}

@end
