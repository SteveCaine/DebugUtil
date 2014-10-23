//
//	Debug_MapKit.h
//	MapUtil
//
//	debug code for CoreLocation and MapKit
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
NSString *str_CLError(CLError err);
NSString *str_CLError_desc(CLError err, NSString **desc);
NSString *str_CLAuthorizationStatus(CLAuthorizationStatus status);
NSString *str_curCLAuthorizationStatus();
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
void d_CLError(CLError err, NSString *label);
void d_CLError_desc(CLError err, NSString *label);
void d_CLAuthorizationStatus(CLAuthorizationStatus status, NSString *label);
void d_curCLAuthorizationStatus(NSString *label);
// ----------------------------------------------------------------------

#else

#define d_CLLocationDegrees(d,l)
#define d_CLLocationCoordinate2D(p,l)
#define d_MKCoordinateSpan(s,l)
#define d_MKCoordinateRegion(r,l)
#define d_MKMapPoint(p,l)
#define d_MKMapSize(s,l)
#define d_MKMapRect(r,l)
#define d_CLError(e,l)
#define d_CLError_desc(e,l)
#define d_CLAuthorizationStatus(s,l)
#define d_curCLAuthorizationStatus(l)

#endif
