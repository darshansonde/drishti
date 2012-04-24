//
//  DMapView.m
//  DMapView
//
//  Created by  on 24/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DMapView.h"
#import "SBHeatMapKmlParser.h"


#define RADIANS(angle) ((angle) / 180.0 * M_PI)

#define kRValue 6378.1
#define keValue 2.718281828
#define kLongitude0 0
#define kXExtents M_PI
#define kYExtents 2*RADIANS(67)

#define kDefaultCountryColor [UIColor colorWithRed:244.0/255.0 green:243.0/255.0 blue:240.0/255.0 alpha:1.0]
#define kDefaultOceanColor [UIColor colorWithRed:165.0/255.0 green:191.0/255.0 blue:221.0/255.0 alpha:1.0]

@implementation DMapView

@synthesize data;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.data = [SBHeatMapKmlParser parseGoogleEarthKmlDoc];
        self.backgroundColor = kDefaultOceanColor;
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
	id key = nil;
	NSEnumerator *enumerator = [self.data keyEnumerator];
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGContextBeginPath(c);
	CGContextTranslateCTM(c, 0, self.frame.size.height);
	CGContextScaleCTM(c, 1.0, -1.0);
	
	while (key = [enumerator nextObject]) {
		NSArray *countryBoundaryArray = [self.data objectForKey:key];
		
		for (int arrayCount = 0; arrayCount < [countryBoundaryArray count]; arrayCount++) {
			NSString *coordinatesString= [[NSString alloc] initWithString:[countryBoundaryArray objectAtIndex:arrayCount]];		
			NSArray *coordinatesArray = [coordinatesString componentsSeparatedByString:@" "];
			NSMutableArray *latitudeArray = [[NSMutableArray alloc] init];
			NSMutableArray *longitudeArray = [[NSMutableArray alloc] init];
			
			for (int k = 0; k < [coordinatesArray count]; k++) {
				[longitudeArray addObject:[(NSArray *)[(NSString *)[coordinatesArray objectAtIndex:k] componentsSeparatedByString:@","] objectAtIndex:0]];
				[latitudeArray addObject:[(NSArray *)[(NSString *)[coordinatesArray objectAtIndex:k] componentsSeparatedByString:@","] objectAtIndex:1]];
			}
			
			CGPoint mapViewCoordinates1 = [self convertPointFromLocation:
                                           CLLocationCoordinate2DMake(
                                    [[latitudeArray objectAtIndex:0] floatValue],
                                    [[longitudeArray objectAtIndex:0] floatValue]) ];
			CGContextMoveToPoint(c, mapViewCoordinates1.x, mapViewCoordinates1.y);
            
			for (int i = 0; i < [latitudeArray count]-1; i++) {
				CGPoint mapViewCoordinates2 = [self convertPointFromLocation:CLLocationCoordinate2DMake([[latitudeArray objectAtIndex:i] floatValue], [[longitudeArray objectAtIndex:i] floatValue])
                                               ];
                
				CGContextAddLineToPoint(c, mapViewCoordinates2.x, mapViewCoordinates2.y);
			}                                                                                                                                                                
                                                                                                                                                                                       
			
            CGContextSetFillColorWithColor(c, kDefaultCountryColor.CGColor);
                                                                                                                                                                                    
			
			CGContextFillPath(c);
		}
	}
    
}

-(CGPoint) convertPointFromLocation:(CLLocationCoordinate2D) location
{
    CGFloat latScaleFactor = self.frame.size.height/(2*kYExtents);
	CGFloat lonScaleFactor = self.frame.size.width/(2*kXExtents);
	CGFloat xLonValue =(RADIANS(location.longitude) - RADIANS(kLongitude0));
	CGFloat yLatValue =(log10f(fabs((1+sin(RADIANS(location.latitude)))/cos(RADIANS(location.latitude))))/log10f(keValue));
	xLonValue = (xLonValue+kXExtents)*lonScaleFactor;
	yLatValue = (yLatValue+kYExtents)*latScaleFactor;
	
	return CGPointMake(xLonValue, yLatValue);
}


@end
