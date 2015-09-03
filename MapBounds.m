//
//  MapBounds.m
//  BeatCityBoston2
//
//  Created by Steve Caine on 09/03/15.
//  Copyright (c) 2015 Steve Caine. All rights reserved.
//

#import "MapBounds.h"

// global constant
const MapBounds MapBoundsNull = {0,0,0,0};

// ----------------------------------------------------------------------

// NULL MapBounds
// CGGeometry Reference: 'rectangle is equal to the null rectangle'
// "A null rectangle is the equivalent of an empty set.
//  For example, the result of intersecting two disjoint rectangles is a null rectangle.
//  A null rectangle cannot be drawn and interacts with other rectangles in special ways.
//  ... For example, the union of a rectangle with the null rectangle is the original rectangle
//  (that is, the null rectangle contributes nothing)."
BOOL MapBoundsIsNull( MapBounds bounds) {
	return bounds.north < bounds.south || bounds.east < bounds.west;
}

// EMPTY MapBounds
// CGGeometry Reference: 'rectangle has zero width or height, or is a null rectangle'
BOOL MapBoundsIsEmpty(MapBounds bounds) {
	return bounds.north <= bounds.south || bounds.east <= bounds.west;
}

// ----------------------------------------------------------------------

BOOL MapBoundsIsValid(MapBounds bounds) {
	return (bounds.north <=  90.0 &&
			bounds.south >= -90.0 &&
			bounds.east <=  180.0 &&
			bounds.west >= -180.0 &&
			// < not <= as 'valid' here includes not being empty
			bounds.north > bounds.south &&
			bounds.east > bounds.west);
}

// ----------------------------------------------------------------------
// per Apple's docs for CGRectUnion()
// "Both rectangles are standardized prior to calculating the union. If either of the rectangles is a null rectangle, a copy of the other rectangle is returned (resulting in a null rectangle if both rectangles are null). Otherwise a rectangle that completely contains the source rectangles is returned."

MapBounds MapBoundsUnion(MapBounds b1, MapBounds b2) {
	MapBounds result = MapBoundsNull;
	
	if (MapBoundsIsValid(b1) && MapBoundsIsValid(b2)) {
		// fmax() takes/returns doubles
		result.north = fmax(b1.north, b2.north);
		result.south = fmax(b1.south, b2.south);
		result.east  = fmax(b1.east,  b2.east);
		result.west  = fmax(b1.west,  b2.west);
	}
	else if (MapBoundsIsValid(b1) && !MapBoundsIsValid(b2))
		result = b1;
	else if (!MapBoundsIsValid(b1) && MapBoundsIsValid(b2))
		result = b2;
	
	return result;
}

// ----------------------------------------------------------------------

BOOL GetMapBoundsFromNSArray(MapBounds *boundsP, NSArray *array) {
	BOOL result = NO;
	
	if (boundsP && array.count == 4) {
		NSNumber *nums[4] = { nil, nil, nil, nil };
		NSUInteger index = 0;
		
		BOOL allNums = YES;
		for (id obj in array) {
			if ([obj isKindOfClass:[NSNumber class]]) {
				nums[index++] = (NSNumber *)obj;
			}
			else {
				allNums = NO;
				break;
			}
		}
		if (allNums) {
			MapBounds bounds = {
				[nums[0] doubleValue], // north
				[nums[0] doubleValue], // south
				[nums[0] doubleValue], // east
				[nums[0] doubleValue], // west
			};
			if (MapBoundsIsValid(bounds)) {
				*boundsP = bounds;
				result = YES;
			}
		}
	}	
	return result;
}

// ----------------------------------------------------------------------

NSString *str_MapBounds(MapBounds bounds) {
	return [NSString stringWithFormat:@"{ %f, %f, %f, %f } (NSEW)",
			bounds.north, bounds.south, bounds.east, bounds.west];
}


// ----------------------------------------------------------------------
