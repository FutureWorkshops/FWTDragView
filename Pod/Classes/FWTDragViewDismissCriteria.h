//
//  FWTDragViewDismissCriteria.h
//  FWTDragView
//
//  Created by Tim Chilvers on 08/09/2014.
//  Copyright (c) 2014 Tim Chilvers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FWTDraggable;
@class FWTDragView;


/**
 *  FWTDragViewDismissCriteria - FWTDragView uses objects conforming to this protocol in order to decide how and when a draggable view is dismissed, and dressing the view appropriately for it's current state of dismissal
 */

@protocol FWTDragViewDismissCriteria <NSObject>

@required

/**
 *  dismissDragView - The drag view calls this when the threshold of dragViewDismissPercentage reaches 1.0 or greater for the first time.
                        It should also be able to handle an external call to this method in order to animate the drag view off the screen.
 *
 *  @param dragView asdf
 *
 *  @return asdf
 */


- (void)dismissDragView:(UIView <FWTDraggable> *)dragView animated:(BOOL)animated;

/**
 *  canDismissDragView - The drag view calls this in order to tell if the dismiss criteria will let the draggable view be dismissed.
 *
 *  @param dragView - the drag view in questions
 *
 *  @return YES - the drag view will continue with dismissal and call dismissDragView
            NO - the drag view will halt the dismissal chain.
 */

- (BOOL)canDismissDragView:(UIView <FWTDraggable> *)dragView;

/**
 *  overlayOnDragView - The drag view calls this repeatedly to construct (Once, preferably) and repeatedly configure the overlay view inside the
 *
 *  @param dragView asdf
 *
 *  @return asdf
 */

- (UIView *)overlayOnDragView:(UIView <FWTDraggable> *)dragView;

/**
 *  dismissPercentageConfiguringDraggable - Called to find out how complete the dismissal is for the dragview. 
                                            This is the callback to configure the drag view relating to the calculated dismiss percentage.
 *
 *  @param dragView - the view in question
 *
 *  @return completion - Percentage complete of the dismissal. Return < 0 for none, >= 1 for complete
 */

- (CGFloat)dismissPercentageConfiguringDraggable:(UIView <FWTDraggable> *)draggable;

@end
