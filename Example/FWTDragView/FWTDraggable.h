//
//  FWTDraggable.h
//  FWTDragView
//
//  Created by Tim Chilvers on 15/09/2014.
//  Copyright (c) 2014 Tim Chilvers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FWTDragViewDelegate, FWTDragViewDismissCriteria;

@protocol FWTDraggable <NSObject>

@required

- (void)dismissWithCriteria:(id <FWTDragViewDismissCriteria>)dismissCriteria;

- (CGPoint)draggedTo;
- (void)setDraggedTo:(CGPoint)draggedTo;

- (NSArray *)dismissCriteria;

- (NSTimeInterval) dismissAnimationDuration;
- (void)setDismissAnimationDuration:(NSTimeInterval)dismissAnimationDuration;

- (NSTimeInterval) centerAnimationDuration;
- (void)setCenterAnimationDuration:(NSTimeInterval)centerAnimationDuration;

- (id <FWTDragViewDelegate>) dragDelegate;

- (CGPoint)lastTouchPoint;
- (void)setLastTouchPoint:(CGPoint)lastTouchPoint;

- (CGPoint)currentTouchPoint;
- (void)setCurrentTouchPoint:(CGPoint)currentTouchPoint;

- (CGPoint)initialTouchPoint;
- (void)setInitialTouchPoint:(CGPoint)initialTouchPoint;

- (void)resetToInitialPosition;

@end
