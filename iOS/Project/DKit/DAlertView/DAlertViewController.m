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
                                        cancelButtonTitle:@"OK" cancelTapBlock:^(UIAlertView* alert){
                                            self.outputLabel.text = @"no button alert OK tapped";
                                        }];
    [alert show];
}

- (IBAction)alert1Button:(id)sender {
    DAlertView *alert = [[DAlertView alloc] initWithTitle:@"title"
                                                  message:@"message"
                                        cancelButtonTitle:@"cancel" cancelTapBlock:^(UIAlertView *alert) {
                                            self.outputLabel.text = @"CANCEL in alert 1 button";
                                        }];
    
    [alert addButtonWithTitle:@"OK" tapBlock:^(UIAlertView *alert) {
        
       self.outputLabel.text = @"OK tapped in alert 1 button";
    }];
    [alert show];
}

- (IBAction)alert2Button:(id)sender {
    DAlertView *alert = [[DAlertView alloc] initWithTitle:@"title"
                                                  message:@"message"
                                        cancelButtonTitle:@"NO" cancelTapBlock:^(UIAlertView *alert) {
                                            self.outputLabel.text = @"CANCEL in alert 2 button";
                                        }];
    
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
                                        cancelButtonTitle:@"NO" cancelTapBlock:^(UIAlertView *alert) {
                                            self.outputLabel.text = @"CANCEL in alert 3 button";
                                        }];
    
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
                                        cancelButtonTitle:@"cancel" cancelTapBlock:^(UIAlertView *alert) {
                                            self.outputLabel.text = @"CANCEL input type";
                                        }];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [alert addButtonWithTitle:@"OK" tapBlock:^(UIAlertView *alert) {
        
        self.outputLabel.text = [NSString stringWithFormat:@"Got Input %@",[alert textFieldAtIndex:0].text];
    }];
    [alert show];
}

- (IBAction)alertLoginType:(id)sender {
    DAlertView *alert = [[DAlertView alloc] initWithTitle:@"title"
                                                  message:@"message"
                                        cancelButtonTitle:@"cancel" cancelTapBlock:^(UIAlertView *alert) {
                                            self.outputLabel.text = @"CANCEL login type";
                                        }];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    [alert addButtonWithTitle:@"OK" tapBlock:^(UIAlertView *alert) {
        
        self.outputLabel.text = [NSString stringWithFormat:@"Got Login %@",[alert textFieldAtIndex:0].text];
        self.outputLabel.text = [NSString stringWithFormat:@"Got Password %@",[alert textFieldAtIndex:1].text];

    }];
    [alert show];

}

@end

/* ==SNIPPETS==
 
