//
//  DImageViewController.h
//  DPreviewController
//
//  Created by Darshan Sonde on 08/10/12.
//

#import <UIKit/UIViewController.h>

/*!
 shows a centered zoomable image view.
 */
@interface DPreviewController : UIViewController

@property (nonatomic, strong) UIImage *image;

-(id) initWithImage:(UIImage*)image;

@end
