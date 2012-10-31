//
//  DActionSheet.h
//  DKit
//
//  Created by Darshan Sonde on 17/10/12.
//
//

#import <UIKit/UIActionSheet.h>

typedef void (^DActionSheetTapBlock)(UIActionSheet *me);

/*!
 Basic UI ActionSheet with blocks. all features of UIActionSheet still accessible
 */
@interface DActionSheet : UIActionSheet

/*!
 create an action sheet with title
 */
-(id) initWithTitle:(NSString*) title;

/*!
 add a button to the action sheet. 
 @sa addDestructiveButton:tapBlock:
 @sa addCancelButton:tapBlock:
 */
-(NSInteger) addButtonWithTitle:(NSString *)title tapBlock:(DActionSheetTapBlock)block;

/*!
 add a destructive button to the action sheet. this resets destructiveButtonIndex.
 @sa addButtonWithTitle:tapBlock:
 @sa addCancelButton:tapBlock:
 */
-(NSInteger) addDestructiveButtonWithTitle:(NSString *)title tapBlock:(DActionSheetTapBlock)block;

/*!
 add a cancel button to the action sheet. this resets cancelButtonIndex.
 @sa addButtonWithTitle:tapBlock:
 @sa addDestructiveButtonWithTitle:tapBlock:
 */
-(NSInteger) addCancelButtonWithTitle:(NSString *)title tapBlock:(DActionSheetTapBlock)block;

@end
