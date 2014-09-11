//
//  FWTDragViewPanGestureHandler.h
//  FWTDragView
//
//  Created by Tim Chilvers on 09/09/2014.
//  Copyright (c) 2014 Tim Chilvers. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FWTDragView;

@interface FWTDragViewPanGestureHandler : NSObject

- (void)prepareForReuse;

+ (instancetype)draggingGestureHandlerAttachedToView:(FWTDragView *)dragView;

@end
