//
//	Debug_ObjC.m
//	DebugUtil
//
//	Created by Steve Caine on 07/12/14.
//	Split from Debug_iOS on 04/27/17.
//
//	This code is distributed under the terms of the MIT license.
//
//	Copyright (c) 2011-2017 Steve Caine.
//

#import "Debug_ObjC.h"

#import <UIKit/UIKit.h>

#import <objc/runtime.h>

// ----------------------------------------------------------------------
#if USECUSTOMLOGS_WRAPPER
void MyLog2(NSString *msg) {
	CFShow((__bridge CFStringRef)msg);
}
#endif
// ----------------------------------------------------------------------

// ----------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------
// ALWAYS
// ----------------------------------------------------------------------

NSString *str_AppName(void) {
	NSString * const key_CFBundleName = @"CFBundleName";
	NSString *result = [NSBundle.mainBundle.infoDictionary objectForKey:key_CFBundleName];
	return result;
}

NSString *str_AppDisplayName(void) {
	NSString * const key_CFBundleDisplayName = @"CFBundleDisplayName";
	NSString *result = [NSBundle.mainBundle.infoDictionary objectForKey:key_CFBundleDisplayName];
	return result;
}

NSString *str_iOS_version(void) { // "7.1", "8.0", etc.
	return [UIDevice.currentDevice systemVersion];
}

NSString *str_device_OS_UDID(void) {
	NSMutableString *result = NSMutableString.string;
	
	NSString *model = [UIDevice.currentDevice model];
	NSString *systemVersion = [UIDevice.currentDevice systemVersion];
	NSString *systemName = [UIDevice.currentDevice systemName];
	[result appendFormat:@"on '%@' running ver %@ of %@", model, systemVersion, systemName];
	
	NSString *name = [UIDevice.currentDevice name];
	NSString *str_idiom = nil;
	UIUserInterfaceIdiom idiom = [UIDevice.currentDevice userInterfaceIdiom];
	switch (idiom) {
		case UIUserInterfaceIdiomPhone: str_idiom = @"Phone";	break;
		case UIUserInterfaceIdiomPad:	str_idiom = @"Pad";		break;
		default:
			str_idiom = [NSString stringWithFormat:@"??? (%lu)", idiom];
			break;
	}
	[result appendFormat:@"\nname = '%@', idiom = '%@'", name, str_idiom];
	
	NSUUID *udid = [UIDevice.currentDevice identifierForVendor];
	NSString *str_udid = udid.UUIDString;
	[result appendFormat:@"\nudid = '%@'", str_udid];
	
	return result;
}

// ----------------------------------------------------------------------

NSString *str_AppPath(void) {
	NSBundle *mailBundle = NSBundle.mainBundle;
	NSString *resourcePath = mailBundle.resourcePath;
	return resourcePath;
}

NSString *str_DocumentsPath(void) {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return paths.firstObject;
}

NSString *str_CachePath(void) {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	return paths.firstObject;
}

// ----------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------
// from reply to http://stackoverflow.com/questions/11774162/list-of-class-properties-in-objective-c

NSArray* propertyNamesForObject(NSObject *obj) {
	NSMutableArray *result = @[].mutableCopy;
	
	unsigned count;
	objc_property_t *properties = class_copyPropertyList(obj.class, &count);
	
	unsigned i;
	for (i = 0; i < count; i++)     {
		objc_property_t property = properties[i];
		NSString *name = [NSString stringWithUTF8String:property_getName(property)];
		[result addObject:name];
	}
	
	free(properties);
	
	return result;
}

// ----------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------
NSString *str_logTime(NSDate *date) { // '09:28:38 AM'
	NSString *result = nil;
	if (date) {
		static NSDateFormatter *timeFormatter;
		if (timeFormatter == nil) {
			timeFormatter = [[NSDateFormatter alloc] init];
			NSString *timeFormat = @"hh:mm:ss a";
			[timeFormatter setDateFormat:timeFormat];
		}
		result = [timeFormatter stringFromDate:date];
	}
	return result;
}
NSString *str_logDate(NSDate *date) { // '01 Jun 2014'
	NSString *result = nil;
	if (date) {
		static NSDateFormatter *dateFormatter;
		if (dateFormatter == nil) {
			dateFormatter = [[NSDateFormatter alloc] init];
			NSString *dateFormat = @"dd MMM yyyy";
			[dateFormatter setDateFormat:dateFormat];
		}
		result = [dateFormatter stringFromDate:date];
	}
	return result;
}

// ----------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------
#if USECUSTOMLOGS
// ----------------------------------------------------------------------

void log_NSURLSessionDataTask(NSURLSessionDataTask *task, BOOL withHeaders) {
	NSURLRequest *request = task.originalRequest;
	MyLog(@" request.url = '%@'", request.URL.absoluteString);
	if (withHeaders) {
		// log HTTP headers in request and response
		MyLog(@"\n requestHeaders = %@\n", [request allHTTPHeaderFields]);
		log_NSURLResponse(task.response, withHeaders);
	}
}

// ----------------------------------------------------------------------

void log_NSURLResponse(NSURLResponse *response, BOOL withHeaders) {
	MyLog(@" response.url = '%@'", response.URL.absoluteString);
	MyLog(@"    MIME-type = '%@'", response.MIMEType);
	MyLog(@"     encoding = '%@'", response.textEncodingName);
	MyLog(@"    file name = '%@'", response.suggestedFilename);
	
	if ([response isKindOfClass:NSHTTPURLResponse.class]) {
		MyLog(@"  status code = %li", ((NSHTTPURLResponse *)response).statusCode);
	}
	if (withHeaders) {
		if ([response respondsToSelector:@selector(allHeaderFields)]) {
			NSDictionary *headers = [(NSHTTPURLResponse *)response allHeaderFields];
			MyLog(@" responseHeaders = %@", headers);
		}
	}
}

// ----------------------------------------------------------------------
#endif
// ----------------------------------------------------------------------
