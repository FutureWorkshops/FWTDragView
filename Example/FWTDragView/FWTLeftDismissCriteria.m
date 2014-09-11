//
//  FWTLeftDismissCriteria.m
//  FWTDragView
//
//  Created by Tim Chilvers on 10/09/2014.
//  Copyright (c) 2014 Tim Chilvers. All rights reserved.
//

#import "FWTLeftDismissCriteria.h"
#import "FWTDragView.h"

@interface FWTLeftDismissCriteria ()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,assign) CGFloat currentDismissal;

@end


@implementation FWTLeftDismissCriteria


- (void)dismissDragView:(FWTDragView *)dragView animated:(BOOL)animated{
    void(^dismissBlock)(void) = ^ {
        dragView.transform = CGAffineTransformTranslate(dragView.transform, -20.f, 0.f);
    };
    if (animated) {
        [UIView animateWithDuration:0.1f animations:dismissBlock];
    } else {
        dismissBlock();
    }
    
}

- (UIView *)overlayOnDragView:(FWTDragView *)dragView {
    
    if (!self.label) {
        self.label = [[UILabel alloc] init];
        self.label.text = @"LEFT!";
        [self.label sizeToFit];
    }
    
    self.label.alpha = self.currentDismissal;
    return self.label;
}

- (CGFloat)dismissPercentageConfiguringDragView:(FWTDragView *)dragView {
    
    CGFloat startThreshold = -10.f;
    CGFloat finishThreshold = -60.f;
    
    CGFloat currentPan = dragView.transform.tx;
    
    CGFloat rangedPan = (currentPan - startThreshold) / finishThreshold;
    self.currentDismissal = rangedPan;
    return rangedPan;
}


@end
