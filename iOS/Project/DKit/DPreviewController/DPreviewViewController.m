//
//  DViewController.m
//  DPreviewController
//
//  Created by Darshan Sonde on 31/10/12.
//
//

#import "DPreviewViewController.h"
#import "DPreviewController.h"

@interface DPreviewViewController ()

@end

@implementation DPreviewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showPreview:(id)sender {
    DPreviewController *pv = [[DPreviewController alloc] initWithImage:[UIImage imageNamed:@"kat.jpg"]];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:pv];
    nc.navigationBarHidden = YES;
    [self presentViewController:nc animated:YES completion:^{
        
    }];
}

@end
