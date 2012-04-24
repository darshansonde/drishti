//
//  SBHeatMapKmlParser.m
//  GeoHeatMap
//
//  Created by Sanath K on 29/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SBHeatMapKmlParser.h"
#import "TBXML.h"

@implementation SBHeatMapKmlParser

+ (NSDictionary *) parseGoogleEarthKmlDoc
{
	NSString *filepath = [[NSBundle mainBundle] pathForResource:@"earth" ofType:@"kml"];
	NSData *kmlData = [NSData dataWithContentsOfFile:filepath];
	NSMutableDictionary *countryBoundaryDict = [[NSMutableDictionary alloc] init];
	
	static NSString *kName_Document = @"Document";
	static NSString *kName_Placemark = @"Placemark";
	static NSString *kName_ExtendedData = @"ExtendedData";
	static NSString *kName_Data = @"Data";
	static NSString *kName_Name = @"name";
	static NSString *kName_Iso2CodeCountry = @"Iso2CodeCountry";
	static NSString *kName_Value = @"value";
	static NSString *kName_MultiGeometry = @"MultiGeometry";
	static NSString *kName_Polygon = @"Polygon";
	static NSString *kName_OuterBoundaryIs = @"outerBoundaryIs";
	static NSString *kName_LinearRing = @"LinearRing";
	static NSString *kName_Coordinates = @"coordinates";
	
	TBXML * tbxml = [[TBXML alloc] initWithXMLData:kmlData];
    TBXMLElement *root = tbxml.rootXMLElement;
    
	if (root) {
		TBXMLElement *document = [TBXML childElementNamed:kName_Document parentElement:root];
		
		if (document) {
			TBXMLElement *placemark = [TBXML childElementNamed:kName_Placemark parentElement:document];
			
			while (placemark) {
				NSString *key = nil;
				NSMutableArray *countryBoundaryArray = [[NSMutableArray alloc] init];
				
				TBXMLElement *extendedData = [TBXML childElementNamed:kName_ExtendedData parentElement:placemark];
				
				if (extendedData) {
					TBXMLElement *data = [TBXML childElementNamed:kName_Data parentElement:extendedData];
					
					while (data) {
						NSString *attributeValue = [TBXML valueOfAttributeNamed:kName_Name forElement:data];
						
						if ([attributeValue isEqualToString:kName_Iso2CodeCountry])  {
							TBXMLElement *value = [TBXML childElementNamed:kName_Value parentElement:data];
							
							if (value) {
								key = [TBXML textForElement:value];
							}
							break;
						}
						else {
							data = [TBXML nextSiblingNamed:kName_Data searchFromElement:data];
						}
					}
				}
				
				TBXMLElement *multiGeometry_parent = [TBXML childElementNamed:kName_MultiGeometry parentElement:placemark];
				
				if (multiGeometry_parent) {
					TBXMLElement *multiGeometry_child = [TBXML childElementNamed:kName_MultiGeometry parentElement:multiGeometry_parent];
					
					if (multiGeometry_child) {
						TBXMLElement *polygon = [TBXML childElementNamed:kName_Polygon parentElement:multiGeometry_child];
						
						while (polygon) {
							TBXMLElement *outer_boundary = [TBXML childElementNamed:kName_OuterBoundaryIs parentElement:polygon];
							
							if (outer_boundary) {
								TBXMLElement *linear_ring = [TBXML childElementNamed:kName_LinearRing parentElement:outer_boundary];
								
								if (linear_ring) {
									TBXMLElement *coordinates = [TBXML childElementNamed:kName_Coordinates parentElement:linear_ring];
									
									if (coordinates) {
										[countryBoundaryArray addObject:[TBXML textForElement:coordinates]];
									}
								}
							}
							polygon = [TBXML nextSiblingNamed:kName_Polygon searchFromElement:polygon];
						}
					}
					else {
						TBXMLElement *polygon = [TBXML childElementNamed:kName_Polygon parentElement:multiGeometry_parent];
						
						if (polygon) {
							TBXMLElement *outer_boundary = [TBXML childElementNamed:kName_OuterBoundaryIs parentElement:polygon];
							
							if (outer_boundary) {
								TBXMLElement *linear_ring = [TBXML childElementNamed:kName_LinearRing parentElement:outer_boundary];
								
								if (linear_ring) {
									TBXMLElement *coordinates = [TBXML childElementNamed:kName_Coordinates parentElement:linear_ring];
									
									if (coordinates) {
										[countryBoundaryArray addObject:[TBXML textForElement:coordinates]];
									}
								}
							}
						}
					}
				}
				[countryBoundaryDict setObject:countryBoundaryArray forKey:key];
				placemark = [TBXML nextSiblingNamed:kName_Placemark searchFromElement:placemark];
			}
		}
	}
	
	return countryBoundaryDict;
}

@end
