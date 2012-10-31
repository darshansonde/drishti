//
//  DImageViewController.m
//  DPreviewController
//
//  Created by Darshan Sonde on 08/10/12.
//

#import "DPreviewController.h"
#import "DActionSheet.h"

//#define BORDER(x) x.layer.borderColor = [UIColor colorWithRed:(50+(arc4random()%200))/255.0 green:(50+(arc4random()%200))/255.0 blue:(50+(arc4random()%200))/255.0 alpha:1.0].CGColor,x.layer.borderWidth=2.0f
#define BORDER(x)

//#define ENABLE_BLEND

/* layout scrollview to center while zooming */
@interface DScrollView : UIScrollView
@end //implemented at bottom.


@interface DPreviewController ()<UIScrollViewDelegate> {
    BOOL isActionSheetVisible;
}

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation DPreviewController

@synthesize image;
@synthesize scrollView;
@synthesize imageView;

-(id) initWithImage:(UIImage*)image_
{
    self = [self initWithNibName:nil bundle:nil];
    if(self) {
        self.image = image_;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.opaque = NO;
    self.view.backgroundColor = [UIColor blackColor];
    self.view.userInteractionEnabled = YES;
    self.view.multipleTouchEnabled = YES;
#ifdef ENABLE_BLEND
    self.view.alpha = 0.0f;
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 1.0f;
    }];
#endif
    
    UIScrollView *scrolView = [[DScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrolView];
    self.scrollView = scrolView;
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.minimumZoomScale = 1.0f;
    self.scrollView.maximumZoomScale = 4.0f;
    self.scrollView.zoomScale = 1.0f;
    self.scrollView.bouncesZoom = YES;
    self.scrollView.showsHorizontalScrollIndicator = self.scrollView.showsVerticalScrollIndicator = YES;
    self.scrollView.alwaysBounceHorizontal = self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.delegate = self;
    self.scrollView.multipleTouchEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    
//    BORDER(self.scrollView);
    
    //need to keep the size of imageview according to maintain the aspect ratio of image.
    CGRect imageRect;
    CGFloat imageAR = self.image.size.width/self.image.size.height;
    if(imageAR < 1.0) {
        imageRect = CGRectMake(0,0,self.view.bounds.size.height * imageAR, self.view.bounds.size.height);
    } else {
        imageRect = CGRectMake(0,0,self.view.bounds.size.width, self.view.bounds.size.width / imageAR);
    }
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:imageRect];
    
    [self.scrollView addSubview:imgView];
    self.imageView = imgView;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.backgroundColor = [UIColor clearColor];
    self.imageView.image = self.image;
    
    BORDER(self.imageView);
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(320-72,10,62,31);
    [button setTitle:@"Done" forState:UIControlStateNormal];
    button.adjustsImageWhenHighlighted = NO;
    [button addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILongPressGestureRecognizer *recog = [[UILongPressGestureRecognizer alloc] initWithTarget:self   action:@selector(sheet:)];
    [self.view addGestureRecognizer:recog];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

-(UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

-(void) dismiss:(UIGestureRecognizer*)recog
{
    @try {
#ifdef ENABLE_BLEND
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.view.alpha = 0;
                     } completion:^(BOOL finished) {
#endif
                         [self dismissViewControllerAnimated:YES completion:^{
                             //
                         }];
#ifdef ENABLE_BLEND
                     }];
#endif
    } @catch (NSException *exec) {
        NSLog(@"got exeption %@",exec);
    }
}

-(void) sheet:(UIGestureRecognizer*) recog
{
    if(isActionSheetVisible)
        return;
    
    isActionSheetVisible = YES;
    DActionSheet *sheet = [[DActionSheet alloc] initWithTitle:nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [sheet addButtonWithTitle:@"Save Photo" tapBlock:^(UIActionSheet *me) {
        UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, NULL);
        isActionSheetVisible = NO;
    }];
    [sheet addCancelButtonWithTitle:@"Cancel" tapBlock:^(UIActionSheet *me) {
        isActionSheetVisible = NO;
    }];
    [sheet showInView:self.view];
}

@end



#pragma mark - DScrollView

@implementation DScrollView

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIView *zoomView = [self.delegate viewForZoomingInScrollView:self];
    
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = zoomView.frame;
    
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width)
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    else
        frameToCenter.origin.x = 0;
    
    // center vertically
    if (frameToCenter.size.height < boundsSize.height)
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    else
        frameToCenter.origin.y = 0;
    
    zoomView.frame = frameToCenter;
}

@end

