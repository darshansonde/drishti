//
//  DMapView.h
//  DMapView
//
//  Created by  on 24/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface DMapView : UIView

@property (nonatomic,retain) NSDictionary *data;

-(CGPoint) convertPointFromLocation:(CLLocationCoordinate2D) location;

@end
