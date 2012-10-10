//
//  DViewController.m
//  DAboutPage
//
//  Created by Darshan Sonde on 10/10/12.
//
//

#import "DViewController.h"
#import "DWebViewController.h"

@interface DViewController ()

@end

@implementation DViewController

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

- (IBAction)loadWebView:(id)sender {
    DWebViewController *vc = [[DWebViewController alloc] initWithDocument:@"About.doc"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
