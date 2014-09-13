//
//	Debug_MapKit.m
//	MapUtil
//
//	Created by Steve Caine on 05/13/14.
//
//	This code is distributed under the terms of the MIT license.
//
//	Copyright (c) 2014 Steve Caine.
//

#import "Debug_MapKit.h"

#import "Debug_iOS.h"

// ----------------------------------------------------------------------
NSString *str_MKMapPoint(MKMapPoint p) {
	return [NSString stringWithFormat:@"%5.1f,%5.1f (x,y)", p.x, p.y];
}
NSString *str_MKMapSize(MKMapSize s) {
	return [NSString stringWithFormat:@"%5.1f,%5.1f (width,height)", s.width, s.height];
}
NSString *str_MKMapRect(MKMapRect r) {
	return [NSString stringWithFormat:@"{ %5.1f, %5.1f },{ %5.1f, %5.1f } (origin,size)",
			r.origin.x, r.origin.y, r.size.width, r.size.height];
}
// ----------------------------------------------------------------------
NSString *str_CLLocationCoordinate2D(CLLocationCoordinate2D p) {
	return [NSString stringWithFormat:@"{ %f, %f } (lat,lon)", p.latitude, p.longitude];
}
NSString *str_MKCoordinateSpan(MKCoordinateSpan s) {
	return [NSString stringWithFormat:@"{ %f, %f } (latDelta,lonDelta)",
			s.latitudeDelta, s.longitudeDelta];
}
NSString *str_MKCoordinateRegion(MKCoordinateRegion r) {
	return [NSString stringWithFormat:@"{ %f, %f }, { %f, %f } (center,span)",
			r.center.latitude, r.center.longitude,
			r.span.latitudeDelta, r.span.longitudeDelta];
}
// ----------------------------------------------------------------------
// NOTE: for some reason unicode chars are being escaped in this output
// ex., name = "11\U201399 Brewer St" instead of '11–99 Brewer St'

NSString *str_CLPlacemark(CLPlacemark *p) {
	NSMutableString *result = [NSMutableString stringWithString:@"(null)"];
	if (p) {
		[result setString:[NSString stringWithFormat:@"<%@ %p>", NSStringFromClass([p class]), p]];
		
		[result appendFormat:@" {\n\tname = '%@'", p.name];				// string
		
		[result appendFormat:@"\n\tlocation = %@", p.location];			// object
		[result appendFormat:@"\n\tregion = %@", p.region];				// object
		[result appendFormat:@"\n\taddress = %@", p.addressDictionary]; // dict
		
		// the rest are all strings
		[result appendFormat:@"\n\tt'fare = '%@'", p.thoroughfare];
		[result appendFormat:@"\n\t& sub = '%@'", p.subThoroughfare];
		[result appendFormat:@"\n\tlocality = '%@'", p.locality];
		[result appendFormat:@"\n\t& sub = '%@'", p.subLocality];
		[result appendFormat:@"\n\tadmin area = '%@'", p.administrativeArea];
		[result appendFormat:@"\n\t& sub = '%@'", p.subAdministrativeArea];
		[result appendFormat:@"\n\tpostalCode = '%@'", p.postalCode];
		[result appendFormat:@"\n\tISOcountryCode = '%@'", p.ISOcountryCode];
		[result appendFormat:@"\n\tcountry = '%@'", p.country];
		[result appendFormat:@"\n\tinlandWater = '%@'", p.inlandWater];
		[result appendFormat:@"\n\tocean = '%@'", p.ocean];
		[result appendFormat:@"\n\tareasOfInterest = '%@'", p.areasOfInterest];
		
		[result appendString:@"\n}"];
	}
	return result;
}

#if USECUSTOMLOGS
// ----------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------
void d_CLLocationCoordinate2D(CLLocationCoordinate2D p, NSString *label) {
//	MyLog(@"%@ %f,%f (lat,lon)", label, p.latitude, p.longitude);
	MyLog(@"%@%@", label, str_CLLocationCoordinate2D(p));
}
void d_MKCoordinateSpan(MKCoordinateSpan s, NSString *label) {
//	MyLog(@"%@ %f,%f (latDelta,lonDelta)", label, s.latitudeDelta, s.longitudeDelta);
	MyLog(@"%@%@", label, str_MKCoordinateSpan(s));
}
void d_MKCoordinateRegion(MKCoordinateRegion r, NSString *label) {
	MyLog(@"%@%@", label, str_MKCoordinateRegion(r));
}
// ----------------------------------------------------------------------
void d_MKMapPoint(MKMapPoint p, NSString *label) {
	MyLog(@"%@%@", label, str_MKMapPoint(p));
}
void d_MKMapSize(MKMapSize s, NSString *label) {
	MyLog(@"%@%@", label, str_MKMapSize(s));
}
void d_MKMapRect(MKMapRect r, NSString *label) {
	MyLog(@"%@%@", label, str_MKMapRect(r));
}
// ----------------------------------------------------------------------
#endif
