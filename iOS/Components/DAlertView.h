//
//  DAlertView.h
//  DKit
//
//  Created by Darshan Sonde on 13/10/12.
//  Copyright (c) 2012 Darshan Sonde. All rights reserved.
//

#import <UIKit/UIAlertView.h>

typedef void (^DAlertViewTapBlock)(UIAlertView *alert);
typedef BOOL (^DAlertViewShouldEnableFirstOtherButtonBlock)(UIAlertView *);

/*!
 Basic UI Alertview with blocks. all features of UIAlertView still accessible
*/
@interface DAlertView : UIAlertView

/*!
 create a basic UIAlertView with cancel button and return. other buttons should be added using addButtonWithTitle:tapBlock: selector.
 The delegate callbacks will exist in addition to block callbacks.
 @param title the title of alert view can be nil
 @param message the message of alert view
 @param cancelButtonTitle the title of cancel button, placement is by UIAlertView 
 @param cancelTapBlock, will be called apart from the delegate callback.
 */
-(id) initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle cancelTapBlock:(DAlertViewTapBlock)block;

 /*!
 add other button to UIAlertView. to add a cancel button use the initializer with cancelButtonTitle.
 */
-(NSInteger) addButtonWithTitle:(NSString *)title tapBlock:(DAlertViewTapBlock)block;

/*!
 substitute for alertViewShouldEnableFirstOtherButton: delegate callback. if this block is set, the delegate method does not
 get called. all other delegate methods are unaffected.
 */
@property (nonatomic,copy) DAlertViewShouldEnableFirstOtherButtonBlock alertViewShouldEnableFirstOtherButtonBlock;


@end
