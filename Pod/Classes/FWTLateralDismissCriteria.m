//
//  FWTLateralDismissCriteria.m
//  FWTDragView
//
//  Created by Tim Chilvers on 15/09/2014.
//  Copyright (c) 2014 Tim Chilvers. All rights reserved.
//

#import "FWTLateralDismissCriteria.h"
#import "FWTDraggable.h"

@interface FWTLateralDismissCriteria () <UIAlertViewDelegate>

@property (nonatomic) CGFloat start;
@property (nonatomic) CGFloat end;
@property (nonatomic) CGFloat target;

@property (nonatomic) UILabel *label;
@property (nonatomic) CGFloat currentDismissal;

@property (nonatomic,weak) id <FWTDraggable> dismissOnAlert;
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

- (BOOL)canDismissDragView:(UIView<FWTDraggable> *)dragView {
    
    BOOL canDismiss = arc4random() % 2;
    
    if (!canDismiss) {
        self.dismissOnAlert = dragView;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Couldn't dismiss" message:@"If you press OK, the drag view will dismiss. If you press cancel, it will center again." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alert show];
    }
    return canDismiss;
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

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (alertView.cancelButtonIndex == buttonIndex) {
        [UIView animateWithDuration:0.1f animations:^{
            [self.dismissOnAlert resetToInitialPosition];
        }];
    } else {
        [self.dismissOnAlert dismissWithCriteria:self];
    }
}

@end
