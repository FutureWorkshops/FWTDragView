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
- (void)dragViewWillEndDragging:(FWTDragView *)dragView;
- (void)dragViewDidEndDragging:(FWTDragView *)dragView;
@end
