//
//  DActionSheet.m
//  DKit
//
//  Created by Darshan Sonde on 17/10/12.
//
//

#import "DActionSheet.h"

@interface DActionSheet () <UIActionSheetDelegate> {
    NSMutableDictionary     *_tapBlocksDictionary;
    NSObject<UIActionSheetDelegate> *_externalDelegate;
    
    struct {
        unsigned int delegateActionSheetClickedButtonAtIndex:1;
		unsigned int delegateActionSheetCancel:1;
		unsigned int delegateWillPresentActionSheetView:1;
        unsigned int delegateDidPresentActionSheet:1;
		unsigned int delegateActionSheetWillDismissWithButtonIndex:1;
        unsigned int delegateActionSheetDidDismissWithButtonIndex:1;
	} _delegateFlags;
}
@end

@implementation DActionSheet

-(id) initWithTitle:(NSString *)title
{
    self = [super initWithTitle:title
                       delegate:self
              cancelButtonTitle:nil
         destructiveButtonTitle:nil
              otherButtonTitles:nil];
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
        if ([_externalDelegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)])
        {
            _delegateFlags.delegateActionSheetClickedButtonAtIndex = YES;
        }
        
        if ([_externalDelegate respondsToSelector:@selector(actionSheetCancel:)])
        {
            _delegateFlags.delegateActionSheetCancel = YES;
        }
        
        if ([_externalDelegate respondsToSelector:@selector(willPresentActionSheet:)])
        {
            _delegateFlags.delegateWillPresentActionSheetView = YES;
        }
        
        if ([_externalDelegate respondsToSelector:@selector(didPresentActionSheet:)])
        {
            _delegateFlags.delegateDidPresentActionSheet = YES;
        }
        
        if ([_externalDelegate respondsToSelector:@selector(actionSheet:willDismissWithButtonIndex:)])
        {
            _delegateFlags.delegateActionSheetWillDismissWithButtonIndex = YES;
        }
        
        if ([_externalDelegate respondsToSelector:@selector(actionSheet:didDismissWithButtonIndex:)])
        {
            _delegateFlags.delegateActionSheetDidDismissWithButtonIndex = YES;
        }
    }
    
}
-(id) delegate
{
    return _externalDelegate;
}


-(NSInteger) addButtonWithTitle:(NSString *)title tapBlock:(DActionSheetTapBlock)block
{
    NSInteger index = [super addButtonWithTitle:title];
    
    if(block)
        [_tapBlocksDictionary setObject:block forKey:@(index)];
    return index;
}

-(NSInteger) addDestructiveButtonWithTitle:(NSString *)title tapBlock:(DActionSheetTapBlock)block
{
    NSInteger index = [self addButtonWithTitle:title tapBlock:block];
    self.destructiveButtonIndex = index;
    
    return index;
}

-(NSInteger) addCancelButtonWithTitle:(NSString *)title
{
    NSInteger index = [super addButtonWithTitle:title];
    self.cancelButtonIndex = index;
    
    return index;
}

#pragma mark - 
#pragma UIActionSheetDelegate (forwarded)

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
	if (_delegateFlags.delegateActionSheetCancel)
		[_externalDelegate actionSheetCancel:actionSheet];
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
	if (_delegateFlags.delegateWillPresentActionSheetView)
		[_externalDelegate willPresentActionSheet:actionSheet];
}

- (void)didPresentActionSheet:(UIActionSheet *)actionSheet
{
	if (_delegateFlags.delegateDidPresentActionSheet)
		[_externalDelegate didPresentActionSheet:actionSheet];
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (_delegateFlags.delegateActionSheetWillDismissWithButtonIndex)
		[_externalDelegate actionSheet:actionSheet willDismissWithButtonIndex:buttonIndex];
}


- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	DActionSheetTapBlock block = [_tapBlocksDictionary objectForKey:@(buttonIndex)];
	
	if (block)
		block(self);
    
	if (_delegateFlags.delegateActionSheetDidDismissWithButtonIndex)
		[_externalDelegate actionSheet:actionSheet didDismissWithButtonIndex:buttonIndex];
}

@end
