//
//  FWTDragViewPanGestureHandler.m
//  FWTDragView
//
//  Created by Tim Chilvers on 09/09/2014.
//  Copyright (c) 2014 Tim Chilvers. All rights reserved.
//

#import "FWTDragViewPanGestureHandler.h"
#import "FWTDragView.h"

@interface FWTDragViewPanGestureHandler()

@property (nonatomic,weak) FWTDragView *draggingView;

@end

@interface FWTDragView (Known)

@property (nonatomic,assign) CGPoint lastTouchPoint;
@property (nonatomic,assign) CGPoint initialTouchPoint;

@end

@implementation FWTDragViewPanGestureHandler

- (void)_updateBasedOnTouchPoints {
    
}

- (void)_panGestureFired:(UIPanGestureRecognizer *)panGesture {
    
    switch (panGesture.state) {
            
        case UIGestureRecognizerStateBegan:
            
            self.draggingView.initialTouchPoint = [panGesture locationInView:self.draggingView];
            self.draggingView.lastTouchPoint = self.draggingView.initialTouchPoint;
            
            if ([self.draggingView.dragDelegate respondsToSelector:@selector(dragViewWillBeginDragging:)]) {
                [self.draggingView.dragDelegate dragViewWillBeginDragging:self.draggingView];
            }
            
            [self _updateBasedOnTouchPoints];
            
            if ([self.draggingView.dragDelegate respondsToSelector:@selector(dragViewDidBeginDragging:)]) {
                [self.draggingView.dragDelegate dragViewDidBeginDragging:self.draggingView];
            }
            break;
            
        case UIGestureRecognizerStateChanged:
            
            self.draggingView.lastTouchPoint = [panGesture locationInView:self.draggingView];
            
            if ([self.draggingView.dragDelegate respondsToSelector:@selector(dragViewWillDrag:)]) {
                [self.draggingView.dragDelegate dragViewWillDrag:self.draggingView];
            }
            
            [self _updateBasedOnTouchPoints];
            
            if ([self.draggingView.dragDelegate respondsToSelector:@selector(dragViewDidDrag:)]) {
                [self.draggingView.dragDelegate dragViewDidDrag:self.draggingView];
            }
            
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            
            self.draggingView.lastTouchPoint = [panGesture locationInView:self.draggingView];
            
            if ([self.draggingView.dragDelegate respondsToSelector:@selector(dragViewWillEndDragging:)]) {
                [self.draggingView.dragDelegate dragViewWillEndDragging:self.draggingView];
            }
            
            [self _updateBasedOnTouchPoints];
            
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
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:handler action:@selector(_panGestureFired:)];
    [dragView addGestureRecognizer:panGesture];
    
    return handler;
    
}

@end
