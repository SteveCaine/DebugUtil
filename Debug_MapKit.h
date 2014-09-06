//
//	Debug_MapKit.h
//	MapDemo
//
//	Created by Steve Caine on 05/13/14.
//
//	This code is distributed under the terms of the MIT license.
//
//	Copyright (c) 2014 Steve Caine.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "Debug_iOS.h"

// ----------------------------------------------------------------------
NSString *str_MKMapPoint(MKMapPoint pt);
NSString *str_MKMapSize(MKMapSize size);
NSString *str_MKMapRect(MKMapRect rect);
// ----------------------------------------------------------------------
NSString *str_CLLocationCoordinate2D(CLLocationCoordinate2D p);
NSString *str_MKCoordinateSpan(MKCoordinateSpan s);
NSString *str_MKCoordinateRegion(MKCoordinateRegion r);
// ----------------------------------------------------------------------
NSString *str_CLPlacemark(CLPlacemark *p);
// ----------------------------------------------------------------------

#if USECUSTOMLOGS

// ----------------------------------------------------------------------
void d_CLLocationDegrees(CLLocationDegrees d, NSString *label);
void d_CLLocationCoordinate2D(CLLocationCoordinate2D p, NSString *label);
// ----------------------------------------------------------------------
void d_MKCoordinateSpan(MKCoordinateSpan s, NSString *label);
void d_MKCoordinateRegion(MKCoordinateRegion r, NSString *label);
// ----------------------------------------------------------------------
void d_MKMapPoint(MKMapPoint p, NSString *label);
void d_MKMapSize(MKMapSize s, NSString *label);
void d_MKMapRect(MKMapRect r, NSString *label);
// ----------------------------------------------------------------------

#else

#define d_CLLocationDegrees(d,l)
#define d_CLLocationCoordinate2D(p,l)
#define d_MKCoordinateSpan(s,l)
#define d_MKCoordinateRegion(r,l)
#define d_MKMapPoint(p,l)
#define d_MKMapSize(s,l)
#define d_MKMapRect(r,l)

#endif
