//
//  FWTLateralDismissCriteria.m
//  FWTDragView
//
//  Created by Tim Chilvers on 15/09/2014.
//  Copyright (c) 2014 Tim Chilvers. All rights reserved.
//

#import "FWTLateralDismissCriteria.h"
#import "FWTDraggable.h"

@interface FWTLateralDismissCriteria ()

@property (nonatomic) CGFloat start;
@property (nonatomic) CGFloat end;
@property (nonatomic) CGFloat target;

@property (nonatomic) UILabel *label;
@property (nonatomic) CGFloat currentDismissal;

@end

@implementation FWTLateralDismissCriteria

+ (instancetype)lateralCriteriaWithStart:(CGFloat)start end:(CGFloat)end target:(CGFloat)target {

    NSAssert((end * end) - (start * start) > 0, @"Start must be smaller than end");
    NSAssert((target * target) - (end * end), @"Target must be larger than end");
    
    FWTLateralDismissCriteria *criteria = [[self alloc] init];
    criteria.start = start;
    criteria.end = end;
    criteria.target = target;
    
    return criteria;
}

- (void)dismissDragView:(UIView <FWTDraggable> *)dragView animated:(BOOL)animated{

    void(^dismissBlock)(void) = ^ {
        dragView.transform = CGAffineTransformTranslate(dragView.transform, self.target, 0.f);
    };
    if (animated) {
        [UIView animateWithDuration:dragView.dismissAnimationDuration animations:dismissBlock];
    } else {
        dismissBlock();
    }
    
}

- (UIView *)overlayOnDragView:(UIView <FWTDraggable> *)dragView {
    
    if (!self.label) {
        self.label = [[UILabel alloc] init];
    }
    self.label.text = [NSString stringWithFormat:@"%.1f%%",(float)self.currentDismissal * 100.f];
    [self.label sizeToFit];
    
    self.label.alpha = self.currentDismissal;
    return self.label;
}

- (CGFloat)dismissPercentageConfiguringDraggable:(UIView <FWTDraggable> *)dragView {
    
    
    CGFloat currentPan = dragView.draggedTo.x;
    
    CGFloat rangedPan = (currentPan - self.start) / self.end;
    self.currentDismissal = rangedPan;
    return rangedPan;
}


@end
