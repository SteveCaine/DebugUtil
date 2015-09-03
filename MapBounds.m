//
//  MapBounds.m
//  BeatCityBoston2
//
//  Created by Steve Caine on 09/03/15.
//  Copyright (c) 2015 Steve Caine. All rights reserved.
//

#import "MapBounds.h"

// ----------------------------------------------------------------------

BOOL MapBoundsIsValid(MapBounds bounds) {
	return (bounds.north <= 90.0 &&
			bounds.south >= -90.0 &&
			bounds.east <= 180.0 &&
			bounds.west >= 180.0 &&
			// < not <= as 'valid' here includes not being empty
			bounds.north > bounds.south &&
			bounds.east > bounds.west);
}

// ----------------------------------------------------------------------

BOOL GetBoundsFromArray(MapBounds *boundsP, NSArray *array) {
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

MapBounds boundsForArray(NSArray *array) {
	MapBounds result = {0,0,0,0};
	
	if (array.count == 4) {
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
			if (MapBoundsIsValid(bounds))
				result = bounds;
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
