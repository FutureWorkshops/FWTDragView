//
//  FWTDragViewDelegate.h
//  FWTDragView
//
//  Created by Tim Chilvers on 08/09/2014.
//  Copyright (c) 2014 Tim Chilvers. All rights reserved.
//

#import <Foundation/Foundation.h>


@class FWTDragView;

@protocol FWTDragViewDelegate <NSObject>

@optional
- (void)dragViewWillBeginDragging:(FWTDragView *)dragView;
- (void)dragViewDidBeginDragging:(FWTDragView *)dragView;

- (void)dragViewWillDrag:(FWTDragView *)dragView;
- (void)dragViewDidDrag:(FWTDragView *)dragView;

- (void)dragViewWillEndDragging:(FWTDragView *)dragView;
- (void)dragViewDidEndDragging:(FWTDragView *)dragView;

- (void)dragViewWillDismiss:(FWTDragView *)dragView;
- (void)dragViewDidDismiss:(FWTDragView *)dragView;

@end
