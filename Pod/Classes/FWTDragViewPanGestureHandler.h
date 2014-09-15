//
//  FWTDragViewPanGestureHandler.h
//  FWTDragView
//
//  Created by Tim Chilvers on 09/09/2014.
//  Copyright (c) 2014 Tim Chilvers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FWTDraggable;

@interface FWTDragViewPanGestureHandler : NSObject

- (void)prepareForReuse;

+ (instancetype)draggingGestureHandlerAttachedToView:(UIView <FWTDraggable> *)dragView;

@end
