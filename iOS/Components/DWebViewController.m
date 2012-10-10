//
//  DWebViewController.m
//  DKit
//
//  Created by Darshan Sonde on 10/10/12.
//
//

#import "DWebViewController.h"

@interface DWebViewController ()

@property UIWebView *webView;

-(void) loadDocument;

@end

@implementation DWebViewController

-(id) initWithDocument:(NSString *)documentName
{
    self = [super initWithNibName:nil bundle:nil];
    if(self) {
        _document = documentName;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [self initWithDocument:nil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
    
    if(self.document) {
        [self loadDocument];
    }
}

-(void) loadDocument
{
    NSString *path = [[NSBundle mainBundle] pathForResource:self.document ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

-(void) setDocument:(NSString *)documentPath
{
    _document = documentPath;
    [self loadDocument];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
