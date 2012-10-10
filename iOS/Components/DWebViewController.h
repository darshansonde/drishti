//
//  DWebViewController.h
//  DKit
//
//  Created by Darshan Sonde on 10/10/12.
//
//

#import <UIKit/UIKit.h>

/* simple offline web view controller */

@interface DWebViewController : UIViewController

@property (nonatomic) NSString *document;//loads the document

-(id) initWithDocument:(NSString*)documentName;

@end
