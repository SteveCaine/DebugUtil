//
//	Debug_iOS.m
//	DebugUtil
//
//	Created by Steve Caine on 07/12/14.
//
//	This code is distributed under the terms of the MIT license.
//
//	Copyright (c) 2014 Steve Caine.
//

#import "Debug_iOS.h"

// ----------------------------------------------------------------------
NSString *str_AppName() {
	const NSString *key_CFBundleName = @"CFBundleName";
	NSString *result = [[[NSBundle mainBundle] infoDictionary] objectForKey:key_CFBundleName];
	return result;
}
NSString *str_AppDisplayName() {
	const NSString *key_CFBundleDisplayName = @"CFBundleDisplayName";
	NSString *result = [[[NSBundle mainBundle] infoDictionary] objectForKey:key_CFBundleDisplayName];
	return result;
}
NSString *str_iOS_version() { // "7.1", "8.0", etc.
	return [[UIDevice currentDevice] systemVersion];
}
NSString *str_device_OS_UDID() {
	NSMutableString *result = [NSMutableString string];
	
	NSString *model = [[UIDevice currentDevice] model];
	NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
	NSString *systemName = [[UIDevice currentDevice] systemName];
	[result appendFormat:@"on '%@' running ver %@ of %@", model, systemVersion, systemName];
	
	NSString *name = [[UIDevice currentDevice] name];
	NSString *str_idiom = nil;
	UIUserInterfaceIdiom idiom = [[UIDevice currentDevice] userInterfaceIdiom];
	switch (idiom) {
		case UIUserInterfaceIdiomPhone: str_idiom = @"Phone";	break;
		case UIUserInterfaceIdiomPad:	str_idiom = @"Pad";		break;
		default:
			str_idiom = [NSString stringWithFormat:@"??? (%i)", (int)idiom];
			break;
	}
	[result appendFormat:@"\nname = '%@', idiom = '%@'", name, str_idiom];
	
	NSUUID *udid = [[UIDevice currentDevice] identifierForVendor];
	NSString *str_udid = [udid UUIDString];
	[result appendFormat:@"\nudid = '%@'", str_udid];
	
	return result;
}
// ----------------------------------------------------------------------
NSString *str_AppPath() {
	NSBundle *mailBundle = [NSBundle mainBundle];
	NSString *resourcePath = [mailBundle resourcePath];
	return resourcePath;
}
NSString *str_DocumentsPath() {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths firstObject];
}
NSString *str_CachePath() {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	return [paths firstObject];
}
// ----------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------
NSString *str_logTime(NSDate *date) { // '09:28:38 AM'
	NSString *result = nil;
	if (date) {
		NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
		NSString *timeFormat = @"hh:mm:ss a";
		[timeFormatter setDateFormat:timeFormat];
		result = [timeFormatter stringFromDate:date];
#if !__has_feature(objc_arc)
		[timeFormatter release];
#endif
	}
	return result;
}
NSString *str_logDate(NSDate *date) { // '01 Jun 2014'
	NSString *result = nil;
	if (date) {
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		NSString *dateFormat = @"dd MMM yyyy";
		[dateFormatter setDateFormat:dateFormat];
		result = [dateFormatter stringFromDate:date];
#if !__has_feature(objc_arc)
		[dateFormatter release];
#endif
	}
	return result;
}
// ----------------------------------------------------------------------
NSString *str_AppState(UIApplicationState state) {
	NSString *result = nil;
	switch (state) {
		case UIApplicationStateActive:
			result = @"active";
			break;
		case UIApplicationStateInactive:
			result = @"inactive";
			break;
		case UIApplicationStateBackground:
			result = @"background";
			break;
		default:
			result = [NSString stringWithFormat:@"?state? = %i", (int) state];
			break;
	}
	return result;
}
NSString *str_curAppState() {
	UIApplication *app = [UIApplication sharedApplication];
	return str_AppState(app.applicationState);
}
// ----------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------
NSString *str_CGPoint(CGPoint p) {
	return [NSString stringWithFormat:@"{ %5.1f, %5.1f } (x,y)", p.x, p.y];
}
NSString *str_CGSize(CGSize s) {
	return [NSString stringWithFormat:@"{ %5.1f, %5.1f } (width,height)", s.width, s.height];
}
NSString *str_CGRect(CGRect r) {
	return [NSString stringWithFormat:@"{ %5.1f, %5.1f },{ %5.1f, %5.1f } (origin,size)",
			r.origin.x, r.origin.y, r.size.width, r.size.height];
}
// ----------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------
void tint_visibleCellsInTableView(UITableView *tableView) {
	NSArray *visibleCells = [tableView visibleCells];
	if ([visibleCells count]) {
		UITableViewCell *firstCell = [visibleCells objectAtIndex:0];
		UITableViewCell	 *lastCell = [visibleCells objectAtIndex:[visibleCells count] - 1];
		firstCell.contentView.backgroundColor = [[UIColor blueColor]  colorWithAlphaComponent:0.25];
		lastCell.contentView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.25];
	}
}
// ----------------------------------------------------------------------

#if USECUSTOMLOGS

// ----------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------
void MyLog(NSString *format, ...) {
	/// Stores the 0-N parameters to be inserted into format string.
	va_list args;
	va_start(args, format);
	
	if ([format length]) {
		// add a linebreak if we don't already have one
		if ([format length] &&
			[format characterAtIndex:[format length] - 1] != '\n')
			format = [format stringByAppendingString:@"\n"];
		
		NSString *formattedString = [[NSString alloc] initWithFormat:format arguments:args];
		va_end(args);
		
		[[NSFileHandle fileHandleWithStandardOutput] writeData:[formattedString dataUsingEncoding:NSUTF8StringEncoding]];
#if !__has_feature(objc_arc)
		[formattedString release];
#endif
	}
}
// ----------------------------------------------------------------------
void d_AppState(UIApplicationState state, NSString *label) {
	MyLog(@"%@%@", label, str_AppState(state));
}
void d_curAppState(NSString *label) {
	UIApplication *app = [UIApplication sharedApplication];
	d_AppState(app.applicationState, label);
}
// ----------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------
void d_CGPoint(CGPoint p, NSString *label) {
	MyLog(@"%@%@", label, str_CGPoint(p));
}
void d_CGSize(CGSize s, NSString *label) {
	MyLog(@"%@%@", label, str_CGSize(s));
}
void d_CGRect(CGRect r, NSString *label) {
	MyLog(@"%@%@", label, str_CGRect(r));
}
// ----------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------
void log_visibleRowsInTableView(UITableView *tableView) {
	NSArray *visibleRows = [tableView indexPathsForVisibleRows];
	if ([visibleRows count]) {
		NSIndexPath *firstPath = [visibleRows objectAtIndex:0];
		NSIndexPath	 *lastPath = [visibleRows objectAtIndex:[visibleRows count] - 1];
		MyLog(@" FIRST VISIBLE ROW at [%i:%i]", firstPath.section, firstPath.row);
		MyLog(@"  LAST VISIBLE ROW at [%i:%i]",	 lastPath.section,	lastPath.row);
	}
}
// ----------------------------------------------------------------------
#endif // #if USECUSTOMLOGS
