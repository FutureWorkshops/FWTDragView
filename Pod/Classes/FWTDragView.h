//
//  FWTDragView.h
//  FWTDragView
//
//  Created by Tim Chilvers on 08/09/2014.
//  Copyright (c) 2014 Tim Chilvers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWTDragViewDelegate.h"


@protocol FWTDragViewDismissCriteria;

@interface FWTDragView : UIView

- (CGPoint)touchPoint;
- (CGPoint)touchOffsetFromStart;

- (void)prepareForReuse;

- (void)dismissWithCriteria:(id <FWTDragViewDismissCriteria>)dismissCriteria;

@property (nonatomic,readonly) NSArray *dismissCriteria;
@property (nonatomic) NSTimeInterval dismissAnimationDuration;
@property (nonatomic) NSTimeInterval centerAnimationDuration;
@property (nonatomic,weak) id <FWTDragViewDelegate> dragDelegate;


// Designated initializer
+ (instancetype)dragViewWithDismissCriteria:(NSArray *)dismissCriteria;

@end
