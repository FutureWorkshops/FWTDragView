//
//  FWTRightDismissCriteria.m
//  FWTDragView
//
//  Created by Tim Chilvers on 10/09/2014.
//  Copyright (c) 2014 Tim Chilvers. All rights reserved.
//

#import "FWTRightDismissCriteria.h"
#import "FWTDragView.h"

@interface FWTRightDismissCriteria ()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,assign) CGFloat currentDismissal;

@end

@implementation FWTRightDismissCriteria

- (void)dismissDragView:(FWTDragView *)dragView {
    
    [UIView animateWithDuration:1.1f animations:^{
        dragView.transform = CGAffineTransformTranslate(dragView.transform, 20.f, 0.f);
    }];
}

- (UIView *)overlayOnDragView:(FWTDragView *)dragView {
    
    if (!self.label) {
        self.label = [[UILabel alloc] init];
        self.label.text = @"RIGHT!";
        [self.label sizeToFit];
    }
    
    self.label.alpha = self.currentDismissal;
    return self.label;
}

- (CGFloat)dismissPercentageConfiguringDragView:(FWTDragView *)dragView {
    
    CGFloat startThreshold = 10.f;
    CGFloat finishThreshold = 60.f;
    
    CGFloat currentPan = dragView.transform.tx;
    
    CGFloat rangedPan = (currentPan - startThreshold) / finishThreshold;
    self.currentDismissal = rangedPan;
    return rangedPan;
}

@end
