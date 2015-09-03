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

extern const MapBounds MapBoundsNull; // = {0,0,0,0};

// see comments in .m file
BOOL MapBoundsIsNull( MapBounds bounds);
BOOL MapBoundsIsEmpty(MapBounds bounds);
BOOL MapBoundsIsValid(MapBounds bounds);

MapBounds MapBoundsUnion(MapBounds b1, MapBounds b2);

//MapBounds MapBoundsIntersection(MapBounds b1, MapBounds b2);


BOOL GetMapBoundsFromNSArray(MapBounds *bounds, NSArray *array);


NSString *str_MapBounds(MapBounds bounds);

// ----------------------------------------------------------------------
