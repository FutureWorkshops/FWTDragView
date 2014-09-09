//
//  FWTDragView.m
//  FWTDragView
//
//  Created by Tim Chilvers on 08/09/2014.
//  Copyright (c) 2014 Tim Chilvers. All rights reserved.
//

#import "FWTDragView.h"

@interface FWTDragView ()

@property (nonatomic,strong) NSArray *dismissCriteria;
@property (nonatomic,assign) CGPoint lastTouchPoint;
@property (nonatomic,assign) CGPoint initialTouchPoint;

@end

@implementation FWTDragView

+ (instancetype)dragViewWithDismissCriteria:(NSArray *)dismissCriteria {
    
    FWTDragView *dragView = [[self alloc] init];
    
    dragView.dismissCriteria = dismissCriteria;
    
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

@end
