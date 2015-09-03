//
//  MapBounds.h
//  BeatCityBoston2
//
//  Created by Steve Caine on 09/03/15.
//  Copyright (c) 2015 Steve Caine. All rights reserved.
//

#import <Foundation/Foundation.h>

// ----------------------------------------------------------------------

typedef struct MapBounds {
	double north;
	double south;
	double east;
	double west;
} MapBounds;

BOOL MapBoundsIsValid(MapBounds bounds);

BOOL GetBoundsFromArray(MapBounds *bounds, NSArray *array);

MapBounds boundsForArray(NSArray *array);

NSString *str_MapBounds(MapBounds bounds);

// ----------------------------------------------------------------------
