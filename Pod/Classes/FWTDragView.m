//
//  FWTDragView.m
//  FWTDragView
//
//  Created by Tim Chilvers on 08/09/2014.
//  Copyright (c) 2014 Tim Chilvers. All rights reserved.
//

#import "FWTDragView.h"
#import "FWTDragViewPanGestureHandler.h"
#import "FWTDragViewDismissCriteria.h"

@interface FWTDragView ()

@property (nonatomic) NSTimeInterval dismissAnimationDuration;
@property (nonatomic) NSTimeInterval centerAnimationDuration;

@property (nonatomic,readwrite) NSArray *dismissCriteria;
@property (nonatomic,readwrite) CGPoint lastTouchPoint;
@property (nonatomic,readwrite) CGPoint currentTouchPoint;
@property (nonatomic,readwrite) CGPoint initialTouchPoint;
@property (nonatomic) CGPoint draggedTo;

@property (nonatomic,strong) FWTDragViewPanGestureHandler *gestureHandler;
@end

@implementation FWTDragView

+ (instancetype)dragViewWithDismissCriteria:(NSArray *)dismissCriteria {
    
    FWTDragView *dragView = [[self alloc] init];
    
    dragView.dismissCriteria = dismissCriteria;
    dragView.gestureHandler = [FWTDragViewPanGestureHandler draggingGestureHandlerAttachedToView:dragView];
    
    return dragView;
}

- (void)prepareForReuse {
    
    self.lastTouchPoint = CGPointZero;
    self.initialTouchPoint = CGPointZero;
    self.currentTouchPoint = CGPointZero;
    [self.gestureHandler prepareForReuse];
    self.draggedTo = self.center;
}

- (void)dismissWithCriteria:(id <FWTDragViewDismissCriteria>)dismissCriteria {
    
    if ([self.dragDelegate respondsToSelector:@selector(dragViewWillDismiss:)]) {
        [self.dragDelegate dragViewWillDismiss:self];
    }
    [UIView animateWithDuration:self.dismissAnimationDuration animations:^{
        [dismissCriteria dismissDragView:self animated:NO];
    } completion:^(BOOL finished) {
        if ([self.dragDelegate respondsToSelector:@selector(dragViewDidDismiss:)]) {
            [self.dragDelegate dragViewDidDismiss:self];
        }
    }];
}

- (void)resetToInitialPosition {
    
    [self prepareForReuse];
    
}

@end
