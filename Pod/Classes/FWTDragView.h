//
//  FWTDragView.h
//  FWTDragView
//
//  Created by Tim Chilvers on 08/09/2014.
//  Copyright (c) 2014 Tim Chilvers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWTDragViewDelegate.h"

@interface FWTDragView : UIView

- (CGPoint)touchPoint;
- (CGPoint)touchOffsetFromStart;

@property (nonatomic,weak) id <FWTDragViewDelegate> dragDelegate;


// Designated initializer
+ (instancetype)dragViewWithDismissCriteria:(NSArray *)dismissCriteria;

@end
