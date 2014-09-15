//
//  FWTLateralDismissCriteria.h
//  FWTDragView
//
//  Created by Tim Chilvers on 15/09/2014.
//  Copyright (c) 2014 Tim Chilvers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWTDragViewDismissCriteria.h"

@interface FWTLateralDismissCriteria : NSObject <FWTDragViewDismissCriteria>

+ (instancetype)lateralCriteriaWithStart:(CGFloat)start end:(CGFloat)end target:(CGFloat)target;

@end
