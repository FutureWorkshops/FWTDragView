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

@property (nonatomic,readwrite) NSArray *dismissCriteria;
@property (nonatomic,assign) CGPoint lastTouchPoint;
@property (nonatomic,assign) CGPoint currentTouchPoint;
@property (nonatomic,assign) CGPoint initialTouchPoint;
@property (nonatomic,strong) FWTDragViewPanGestureHandler *gestureHandler;
@end

@implementation FWTDragView

+ (instancetype)dragViewWithDismissCriteria:(NSArray *)dismissCriteria {
    
    FWTDragView *dragView = [[self alloc] init];
    
    dragView.dismissCriteria = dismissCriteria;
    dragView.gestureHandler = [FWTDragViewPanGestureHandler draggingGestureHandlerAttachedToView:dragView];
    
    return dragView;
}


- (CGPoint)touchPoint {
    
    CGPoint point = (CGPoint){self.lastTouchPoint.x,self.lastTouchPoint.y};
    return point;
}

- (CGPoint)touchOffsetFromStart {
    
    CGPoint point = (CGPoint){self.initialTouchPoint.x - self.lastTouchPoint.x,self.initialTouchPoint.y - self.lastTouchPoint.y};
    return point;
}

- (void)prepareForReuse {
    
    self.lastTouchPoint = CGPointZero;
    self.initialTouchPoint = CGPointZero;
    self.currentTouchPoint = CGPointZero;
    [self.gestureHandler prepareForReuse];
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

@end
