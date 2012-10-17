//
//  DViewController.m
//  DAlertView
//
//  Created by Darshan Sonde on 12/10/12.
//
//

#import "DAlertViewController.h"
#import "DAlertView.h"

@interface DAlertViewController ()

@end

@implementation DAlertViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)alertNoButtons:(id)sender {
    DAlertView *alert = [[DAlertView alloc] initWithTitle:@"title"
                                                  message:@"message"
                                        cancelButtonTitle:@"OK"];
    [alert show];
}

- (IBAction)alert1Button:(id)sender {
    DAlertView *alert = [[DAlertView alloc] initWithTitle:@"Two Buttons"
                                                  message:@"Will show yes no dialog when done"
                                        cancelButtonTitle:@"Cancel"];
    
    [alert addButtonWithTitle:@"OK" tapBlock:^(UIAlertView *alert) {
        
       self.outputLabel.text = @"OK tapped in alert 1 button";
        
        
        
        DAlertView *alert2 = [[DAlertView alloc] initWithTitle:@"title"
                                                      message:@"Will show yes no dialog when done"
                                            cancelButtonTitle:nil];
        [alert2 addButtonWithTitle:@"YES" tapBlock:^(UIAlertView *me) {
            self.outputLabel.text = @"YES tapped";
        }];
        [alert2 addButtonWithTitle:@"NO" tapBlock:^(UIAlertView *me) {
            self.outputLabel.text = @"NO tapped";
        }];
        [alert2 show];
    }];
    
    [alert show];
}

- (IBAction)alert2Button:(id)sender {
    DAlertView *alert = [[DAlertView alloc] initWithTitle:@"title"
                                                  message:@"message"
                                        cancelButtonTitle:@"Cancel"];
    
    [alert addButtonWithTitle:@"YES" tapBlock:^(UIAlertView *alert) {
        
        self.outputLabel.text = @"YES in alert 2 button";
    }];
    
    [alert addButtonWithTitle:@"MAYBE" tapBlock:^(UIAlertView *alert) {
        
        self.outputLabel.text = @"MAYBE in alert 2 button";
    }];
    
    [alert show];
}

- (IBAction)alert3Button:(id)sender {
    DAlertView *alert = [[DAlertView alloc] initWithTitle:@"title"
                                                  message:@"message"
                                        cancelButtonTitle:@"Cancel"];
    
    [alert addButtonWithTitle:@"YES" tapBlock:^(UIAlertView *alert) {
        
        self.outputLabel.text = @"YES in alert 3 button";
    }];
    
    [alert addButtonWithTitle:@"MAYBE" tapBlock:^(UIAlertView *alert) {
        
        self.outputLabel.text = @"MAYBE in alert 3 button";
    }];
    [alert addButtonWithTitle:@"CONFUSED" tapBlock:^(UIAlertView *alert) {
        
        self.outputLabel.text = @"CONFUSED in alert 3 button";
    }];

    [alert show];
}

- (IBAction)alertInputType:(id)sender {
    DAlertView *alert = [[DAlertView alloc] initWithTitle:@"title"
                                                  message:@"message"
                                        cancelButtonTitle:@"cancel"];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [alert addButtonWithTitle:@"OK" tapBlock:^(UIAlertView *alert) {
        
        self.outputLabel.text = [NSString stringWithFormat:@"Got Input %@",[alert textFieldAtIndex:0].text];
    }];
    [alert show];
}

- (IBAction)alertLoginType:(id)sender {
    DAlertView *alert = [[DAlertView alloc] initWithTitle:@"title"
                                                  message:@"message"
                                        cancelButtonTitle:@"cancel"
                                    firstOtherButtonTitle:@"OK" firstOtherButtonTapBlock:^(UIAlertView *me) {
                             
                                        self.outputLabel.text = [NSString stringWithFormat:@"Got Login %@\nGot Password %@",[me textFieldAtIndex:0].text,[me textFieldAtIndex:1].text];

                         }];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;

    alert.alertViewShouldEnableFirstOtherButtonBlock = ^BOOL(UIAlertView *me) {
        if([[me textFieldAtIndex:0].text length]<4) {
            return NO;
        }
        return YES;
    };
    
    alert.delegate = self;
    [alert show];
}

@end

/* ==SNIPPETS==
 
 */
 
