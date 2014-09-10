//
//  FWTDragViewPanGestureHandler.m
//  FWTDragView
//
//  Created by Tim Chilvers on 09/09/2014.
//  Copyright (c) 2014 Tim Chilvers. All rights reserved.
//

#import "FWTDragViewPanGestureHandler.h"
#import "FWTDragView.h"
#import "FWTDragViewDismissCriteria.h"

@interface FWTDragViewPanGestureHandler()

@property (nonatomic,weak) FWTDragView *draggingView;
@property (nonatomic,assign) BOOL dismissed;

@end

@interface FWTDragView (Known)

@property (nonatomic,strong) NSArray *dismissCriteria;
@property (nonatomic,assign) CGPoint lastTouchPoint;
@property (nonatomic,assign) CGPoint currentTouchPoint;
@property (nonatomic,assign) CGPoint initialTouchPoint;

@end

@implementation FWTDragViewPanGestureHandler

- (void)_updateBasedOnTouchPoints {
    
    [self.draggingView.dismissCriteria enumerateObjectsUsingBlock:^(id <FWTDragViewDismissCriteria>dismissCriteria, NSUInteger idx, BOOL *stop) {
        CGFloat completion = [dismissCriteria dismissPercentageConfiguringDragView:self.draggingView];
        if (completion > 0.f) {
            *stop = YES;
            
            UIView *overlayView = [dismissCriteria overlayOnDragView:self.draggingView];
            if (overlayView.superview != self.draggingView) {
                [overlayView removeFromSuperview];
                [self.draggingView addSubview:overlayView];
            }
            
            if (completion > 1.f) {
                self.dismissed = YES;
                [dismissCriteria dismissDragView:self.draggingView];
            }
        }
    }];
}

- (void)_panToLastTouchPoint {
    
    CGAffineTransform transform = self.draggingView.transform;
    CGPoint delta = (CGPoint){self.draggingView.currentTouchPoint.x - self.draggingView.lastTouchPoint.x,
        self.draggingView.currentTouchPoint.y - self.draggingView.lastTouchPoint.y};
    
    transform = CGAffineTransformTranslate(transform, delta.x, delta.y);
    
    self.draggingView.transform = transform;
}

- (void)_centerOnFailure {
    
    [UIView animateWithDuration:0.1f animations:^{
        self.draggingView.transform = CGAffineTransformIdentity;
    }];
}

- (void)_panGestureFired:(UIPanGestureRecognizer *)panGesture {
    
    switch (panGesture.state) {
            
        case UIGestureRecognizerStateBegan:
            
            self.draggingView.initialTouchPoint = [panGesture translationInView:self.draggingView];
            self.draggingView.lastTouchPoint = self.draggingView.initialTouchPoint;
            self.draggingView.currentTouchPoint = self.draggingView.initialTouchPoint;
            
            if ([self.draggingView.dragDelegate respondsToSelector:@selector(dragViewWillBeginDragging:)]) {
                [self.draggingView.dragDelegate dragViewWillBeginDragging:self.draggingView];
            }
            
            [self _panToLastTouchPoint];
            [self _updateBasedOnTouchPoints];
            
            if ([self.draggingView.dragDelegate respondsToSelector:@selector(dragViewDidBeginDragging:)]) {
                [self.draggingView.dragDelegate dragViewDidBeginDragging:self.draggingView];
            }
            break;
            
        case UIGestureRecognizerStateChanged:
            
            self.draggingView.currentTouchPoint = [panGesture translationInView:self.draggingView];
            
            if ([self.draggingView.dragDelegate respondsToSelector:@selector(dragViewWillDrag:)]) {
                [self.draggingView.dragDelegate dragViewWillDrag:self.draggingView];
            }
            
            [self _panToLastTouchPoint];
            [self _updateBasedOnTouchPoints];
            
            if ([self.draggingView.dragDelegate respondsToSelector:@selector(dragViewDidDrag:)]) {
                [self.draggingView.dragDelegate dragViewDidDrag:self.draggingView];
            }
            
            self.draggingView.lastTouchPoint = self.draggingView.currentTouchPoint;
            
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            
            self.draggingView.lastTouchPoint = [panGesture translationInView:self.draggingView];
            
            if ([self.draggingView.dragDelegate respondsToSelector:@selector(dragViewWillEndDragging:)]) {
                [self.draggingView.dragDelegate dragViewWillEndDragging:self.draggingView];
            }
            
            if (!self.dismissed) {
                [self _centerOnFailure];
                [self _updateBasedOnTouchPoints];
            }
            
            if ([self.draggingView.dragDelegate respondsToSelector:@selector(dragViewDidEndDragging:)]) {
                [self.draggingView.dragDelegate dragViewDidEndDragging:self.draggingView];
            }
            
            break;
            
        default:
            break;
    }
}

+ (instancetype)draggingGestureHandlerAttachedToView:(FWTDragView *)dragView {
    
    FWTDragViewPanGestureHandler *handler = [[self alloc] init];
    handler.draggingView = dragView;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:handler action:@selector(_panGestureFired:)];
    [dragView addGestureRecognizer:panGesture];
    
    return handler;
    
}

@end
