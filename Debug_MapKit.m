//
//	Debug_MapKit.m
//	MapUtil
//
//	see description in header
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
// ----------------------------------------------------------------------
static NSString *err_desc[][2] = {
	{ @"kCLErrorLocationUnknown",					@"Location is currently unknown, but CL will keep trying" },
	{ @"kCLErrorDenied",							@"Access to location or ranging has been denied by the user" },
	{ @"kCLErrorNetwork",							@"General, network-related error" },
	{ @"kCLErrorHeadingFailure",					@"Heading could not be determined" },
	{ @"kCLErrorRegionMonitoringDenied",			@"Location region monitoring has been denied by the user" },
	{ @"kCLErrorRegionMonitoringFailure",			@"A registered region cannot be monitored" },
	{ @"kCLErrorRegionMonitoringSetupDelayed",		@"CL could not immediately initialize region monitoring" },
	{ @"kCLErrorRegionMonitoringResponseDelayed",	@"While events for this fence will be delivered, delivery will not occur immediately" },
	{ @"kCLErrorGeocodeFoundNoResult",				@"A geocode request yielded no result" },
	{ @"kCLErrorGeocodeFoundPartialResult",			@"A geocode request yielded a partial result" },
	{ @"kCLErrorGeocodeCanceled",					@"A geocode request was cancelled" },
	{ @"kCLErrorDeferredFailed",					@"Deferred mode failed" },
	{ @"kCLErrorDeferredNotUpdatingLocation",		@"Deferred mode failed because location updates disabled or paused" },
	{ @"kCLErrorDeferredAccuracyTooLow",			@"Deferred mode not supported for the requested accuracy" },
	{ @"kCLErrorDeferredDistanceFiltered",			@"Deferred mode does not support distance filters" },
	{ @"kCLErrorDeferredCanceled",					@"Deferred mode request canceled a previous request" },
	{ @"kCLErrorRangingUnavailable",				@"Ranging cannot be performed" },
	{ @"kCLErrorRangingFailure",					@"General ranging failure" }
};
NSUInteger num_err_desc = sizeof(err_desc)/sizeof(err_desc[0]);
// ----------------------------------------------------------------------
NSString *str_CLError(CLError err) {
	if (err >= 0 && err < num_err_desc)
		return err_desc[err][0];
	return nil;
}
// ----------------------------------------------------------------------
NSString *str_CLError_desc(CLError err, NSString **desc) {
	if (desc)
	   *desc = nil;
	if (err >= 0 && err < num_err_desc) {
		if (desc)
		   *desc = err_desc[err][1];
		return err_desc[err][0];
	}
	return nil;
}
// ----------------------------------------------------------------------
static NSString *str_status[] = {
	@"undetermined",
	@"restricted",
	@"denied",
	@"authorized(always)",
	@"authorized(in-use)"
};
NSUInteger num_status = sizeof(str_status)/sizeof(str_status[0]);
// ----------------------------------------------------------------------
NSString *str_CLAuthorizationStatus(CLAuthorizationStatus status) {
	if (status < num_status)
		return str_status[status];
	return nil;
}
// ----------------------------------------------------------------------
NSString *str_curCLAuthorizationStatus() {
	return str_CLAuthorizationStatus([CLLocationManager authorizationStatus]);
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
void d_CLError(CLError err, NSString *label) {
	MyLog(@"%@%@", label, str_CLError(err));
}
void d_CLError_desc(CLError err, NSString *label) {
	NSString *desc = nil;
	NSString *str = str_CLError_desc(err, &desc);
	MyLog(@"%@%@ (%@)", label, str, desc);
}
void d_CLAuthorizationStatus(CLAuthorizationStatus status, NSString *label) {
	MyLog(@"%@%@", label, str_CLAuthorizationStatus(status));
}
void d_curCLAuthorizationStatus(NSString *label) {
	MyLog(@"%@%@", label, str_curCLAuthorizationStatus());
}
// ----------------------------------------------------------------------
#endif
