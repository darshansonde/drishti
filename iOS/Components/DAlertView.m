//
//  DAlertView.m
//  DKit
//
//  Created by Darshan Sonde on 13/10/12.
//
//

#import "DAlertView.h"

@interface DAlertView () <UIAlertViewDelegate> {
    NSMutableDictionary     *_tapBlocksDictionary;
    NSObject<UIAlertViewDelegate> *_externalDelegate;
    
    struct {
        unsigned int delegateAlertViewClickedButtonAtIndex:1;
        unsigned int delegateAlertViewCancel:1;
        unsigned int delegateWillPresentAlertView:1;
        unsigned int delegateDidPresentAlertView:1;
        unsigned int delegateAlertViewWillDismissWithButtonIndex:1;
        unsigned int delegateAlertViewDidDismissWithButtonIndex:1;
        unsigned int delegateAlertViewShouldEnableFirstOtherButton:1;
    } _delegateFlags;
}
@end

@implementation DAlertView


-(id) initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
{
    self = [super initWithTitle:title
                        message:message
                       delegate:self
              cancelButtonTitle:cancelButtonTitle
              otherButtonTitles:nil];
    if(self) {
    }
    return self;
    
}

-(id)   initWithTitle:(NSString *)title
              message:(NSString *)message
    cancelButtonTitle:(NSString *)cancelButtonTitle
firstOtherButtonTitle:(NSString *)otherButtonTitle firstOtherButtonTapBlock:(DAlertViewTapBlock) otherBlock
{
    self = [super initWithTitle:title
                        message:message
                       delegate:self
              cancelButtonTitle:cancelButtonTitle
              otherButtonTitles:otherButtonTitle,nil];
    if(self) {
        NSInteger index = [self firstOtherButtonIndex];
        if(otherBlock)
            [_tapBlocksDictionary setObject:[otherBlock copy] forKey:@(index)];
    }
    return self;

}

- (id)init
{
	self = [super init];
	if (self) {
		_tapBlocksDictionary = [[NSMutableDictionary alloc] init];
		self.delegate = self;
	}
	
	return self;
}

-(void) setDelegate:(id) delegate
{
    // wipe
	memset(&_delegateFlags, 0, sizeof(_delegateFlags));
    
    if(delegate == self || delegate == nil) {
        [super setDelegate:delegate];
        _externalDelegate = nil;
    }
    else {
        _externalDelegate = delegate;
        
        // set flags according to available methods in delegate
        if ([_externalDelegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)])
        {
            _delegateFlags.delegateAlertViewClickedButtonAtIndex = YES;
        }
        
        if ([_externalDelegate respondsToSelector:@selector(alertViewCancel:)])
        {
            _delegateFlags.delegateAlertViewCancel = YES;
        }
        
        if ([_externalDelegate respondsToSelector:@selector(willPresentAlertView:)])
        {
            _delegateFlags.delegateWillPresentAlertView = YES;
        }
        
        if ([_externalDelegate respondsToSelector:@selector(didPresentAlertView:)])
        {
            _delegateFlags.delegateDidPresentAlertView = YES;
        }
        
        if ([_externalDelegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)])
        {
            _delegateFlags.delegateAlertViewWillDismissWithButtonIndex = YES;
        }
        
        if ([_externalDelegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)])
        {
            _delegateFlags.delegateAlertViewDidDismissWithButtonIndex = YES;
        }

        if ([_externalDelegate respondsToSelector:@selector(alertViewShouldEnableFirstOtherButton:)])
        {
            _delegateFlags.delegateAlertViewShouldEnableFirstOtherButton = YES;
        }
    }

}
-(id) delegate
{
    return _externalDelegate;
}

-(NSInteger) addButtonWithTitle:(NSString *)title tapBlock:(DAlertViewTapBlock)block
{
    NSInteger buttonIndex = [self addButtonWithTitle:title];
    if(block)
        [_tapBlocksDictionary setObject:block forKey:@(buttonIndex)];
    return buttonIndex;
}

#pragma mark - alert view delegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    DAlertViewTapBlock tapBlock = [_tapBlocksDictionary objectForKey:@(buttonIndex)];
    if(tapBlock)
        tapBlock(self);
    
    if(_delegateFlags.delegateAlertViewClickedButtonAtIndex)
        [_externalDelegate alertView:alertView clickedButtonAtIndex:buttonIndex];
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    if(_delegateFlags.delegateAlertViewCancel)
        [_externalDelegate alertViewCancel:alertView];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(_delegateFlags.delegateAlertViewWillDismissWithButtonIndex)
        [_externalDelegate alertView:alertView willDismissWithButtonIndex:buttonIndex];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(_delegateFlags.delegateAlertViewDidDismissWithButtonIndex)
        [_externalDelegate alertView:alertView didDismissWithButtonIndex:buttonIndex];
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    if(self.alertViewShouldEnableFirstOtherButtonBlock)
        return self.alertViewShouldEnableFirstOtherButtonBlock(alertView);
    
    if(_delegateFlags.delegateAlertViewShouldEnableFirstOtherButton)
        return [_externalDelegate alertViewShouldEnableFirstOtherButton:alertView];
    
    return YES;
}


@end
