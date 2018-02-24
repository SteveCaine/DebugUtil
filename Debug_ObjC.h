//
//	Debug_ObjC.h
//	DebugUtil
//
//	Minimal debug logging for files using just Foundation headers
//
//	Created by Steve Caine on 07/13/11.
//	Split from Debug_iOS on 04/27/17.
//
//	This code is distributed under the terms of the MIT license.
//
//	Copyright (c) 2011-2017 Steve Caine.
//

#import <Foundation/Foundation.h>

#ifdef	DEBUG
#define USECUSTOMLOGS 			1
#define USECUSTOMLOGS_WRAPPER  (0 && USECUSTOMLOGS)
#endif

// ----------------------------------------------------------------------
#if USECUSTOMLOGS
// ----------------------------------------------------------------------
#define NSLog(...) MyLog(__VA_ARGS__)

#if USECUSTOMLOGS_WRAPPER
	// macro calls CFShow indirectly
	// so we can set a breakpoint in MyLog2() to trap these calls
	void MyLog2(NSString *msg);
#	define MyLog(format, ...) MyLog2([NSString stringWithFormat:format, ## __VA_ARGS__])
#else
	// macro calls CFShow directly
#	define MyLog(format, ...) CFShow((__bridge CFStringRef)[NSString stringWithFormat:format, ## __VA_ARGS__])
#endif // USECUSTOMLOGS_WRAPPER
#endif // USECUSTOMLOGS
// ----------------------------------------------------------------------

// ----------------------------------------------------------------------
// ALWAYS
// ----------------------------------------------------------------------
NSString *str_AppName(void);
NSString *str_AppDisplayName(void);
NSString *str_iOS_version(void);
NSString *str_device_OS_UDID(void);
// ----------------------------------------------------------------------
NSString *str_AppPath(void);
NSString *str_DocumentsPath(void);
NSString *str_CachePath(void);
// ----------------------------------------------------------------------
NSArray* propertyNamesForObject(NSObject *obj);
// ----------------------------------------------------------------------
NSString *str_logTime(NSDate *date); // '08:32:07 PM'
NSString *str_logDate(NSDate *date); // '29 Apr 2017'
// ----------------------------------------------------------------------

// ----------------------------------------------------------------------
#if USECUSTOMLOGS
// ----------------------------------------------------------------------
void log_NSURLSessionDataTask(NSURLSessionDataTask *task, BOOL withHeaders);
void log_NSURLResponse(NSURLResponse *response, BOOL withHeaders);
// ----------------------------------------------------------------------
#else
// ----------------------------------------------------------------------
#define MyLog(format, ...)
#define log_NSURLSessionDataTask(task,withHeaders)
#define log_NSURLResponse(response,withHeaders)
// ----------------------------------------------------------------------
#endif
// ----------------------------------------------------------------------
