//
//  DViewController.m
//  DActionSheet
//
//  Created by Darshan Sonde on 17/10/12.
//
//

#import "DActionSheetViewController.h"
#import "DActionSheet.h"

@interface DActionSheetViewController ()

@end

@implementation DActionSheetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelSheet:(id)sender {
    DActionSheet *action = [[DActionSheet alloc] initWithTitle:nil];
    [action addCancelButtonWithTitle:@"Cancel"];
    [action showInView:self.view];
}
- (IBAction)oneOptionSheet:(id)sender {
    DActionSheet *action = [[DActionSheet alloc] initWithTitle:@"One Option"];
    [action addButtonWithTitle:@"First Button" tapBlock:^(UIActionSheet *me) {
        [[[UIAlertView alloc] initWithTitle:@"One Message Tapped" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    [action addCancelButtonWithTitle:@"Cancel"];
    [action showInView:self.view];
}
- (IBAction)oneOptionDestructiveSheet:(id)sender {
    DActionSheet *action = [[DActionSheet alloc] initWithTitle:@"One Option"];
    [action addButtonWithTitle:@"First Button" tapBlock:^(UIActionSheet *me) {
        [[[UIAlertView alloc] initWithTitle:@"One Message Tapped" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    [action addDestructiveButtonWithTitle:@"Delete Button" tapBlock:^(UIActionSheet *me) {
        [[[UIAlertView alloc] initWithTitle:@"Delete Tapped" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    [action addCancelButtonWithTitle:@"Cancel"];
    [action showInView:self.view];

}
- (IBAction)twoOptionSheet:(id)sender {
    DActionSheet *action = [[DActionSheet alloc] initWithTitle:@"One Option"];
    [action addButtonWithTitle:@"First Button" tapBlock:^(UIActionSheet *me) {
        [[[UIAlertView alloc] initWithTitle:@"One Message Tapped" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    [action addButtonWithTitle:@"Second Button" tapBlock:^(UIActionSheet *me) {
        [[[UIAlertView alloc] initWithTitle:@"Second Tapped" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    [action addCancelButtonWithTitle:@"Cancel"];
    [action showInView:self.view];
}
- (IBAction)twoOptionDestructiveSheet:(id)sender {
    DActionSheet *action = [[DActionSheet alloc] initWithTitle:@"One Option"];
    
    [action addButtonWithTitle:@"First Button" tapBlock:^(UIActionSheet *me) {
        [[[UIAlertView alloc] initWithTitle:@"One Message Tapped" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    [action addButtonWithTitle:@"Second Button" tapBlock:^(UIActionSheet *me) {
        [[[UIAlertView alloc] initWithTitle:@"Second Tapped" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];

    [action addDestructiveButtonWithTitle:@"Delete Button" tapBlock:^(UIActionSheet *me) {
        [[[UIAlertView alloc] initWithTitle:@"Delete Tapped" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    
    [action addCancelButtonWithTitle:@"Cancel"];
    
    [action showInView:self.view];

}
- (IBAction)twoOptionNoCancelSheet:(id)sender {
    
    DActionSheet *action = [[DActionSheet alloc] initWithTitle:@"One Option"];
    [action addButtonWithTitle:@"First Button" tapBlock:^(UIActionSheet *me) {
        [[[UIAlertView alloc] initWithTitle:@"One Message Tapped" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    [action addButtonWithTitle:@"Second Button" tapBlock:^(UIActionSheet *me) {
        [[[UIAlertView alloc] initWithTitle:@"Second Tapped" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    
    [action showInView:self.view];
    

}
- (IBAction)twoOptionNoCancelDestructiveSheet:(id)sender {
    DActionSheet *action = [[DActionSheet alloc] initWithTitle:@"One Option"];
    [action addButtonWithTitle:@"First Button" tapBlock:^(UIActionSheet *me) {
        [[[UIAlertView alloc] initWithTitle:@"One Message Tapped" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    [action addButtonWithTitle:@"Second Button" tapBlock:^(UIActionSheet *me) {
        [[[UIAlertView alloc] initWithTitle:@"Second Tapped" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    
    [action addDestructiveButtonWithTitle:@"Delete Button" tapBlock:^(UIActionSheet *me) {
        [[[UIAlertView alloc] initWithTitle:@"Delete Tapped" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    
    [action showInView:self.view];
    

}

@end
