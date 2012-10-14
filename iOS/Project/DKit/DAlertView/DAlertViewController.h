//
//  DViewController.h
//  DAlertView
//
//  Created by Darshan Sonde on 12/10/12.
//
//

#import <UIKit/UIKit.h>

@interface DAlertViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *outputLabel;

- (IBAction)alertNoButtons:(id)sender;
- (IBAction)alert1Button:(id)sender;
- (IBAction)alert2Button:(id)sender;
- (IBAction)alert3Button:(id)sender;
- (IBAction)alertInputType:(id)sender;
- (IBAction)alertLoginType:(id)sender;
@end
