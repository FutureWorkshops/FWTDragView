//
//  FWTDragViewDelegate.h
//  FWTDragView
//
//  Created by Tim Chilvers on 08/09/2014.
//  Copyright (c) 2014 Tim Chilvers. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol FWTDraggable;

@protocol FWTDragViewDelegate <NSObject>

@optional
- (void)dragViewWillBeginDragging:(UIView <FWTDraggable> *)dragView;
- (void)dragViewDidBeginDragging:(UIView <FWTDraggable> *)dragView;

- (void)dragViewWillDrag:(UIView <FWTDraggable> *)dragView;
- (void)dragViewDidDrag:(UIView <FWTDraggable> *)dragView;

- (void)dragViewWillEndDragging:(UIView <FWTDraggable> *)dragView;
- (void)dragViewDidEndDragging:(UIView <FWTDraggable> *)dragView;

- (void)dragViewWillDismiss:(UIView <FWTDraggable> *)dragView;
- (void)dragViewDidDismiss:(UIView <FWTDraggable> *)dragView;

@end
