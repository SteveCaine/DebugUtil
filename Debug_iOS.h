//
//	Debug_iOS.h
//	DebugUtil
//
//	Created by Steve Caine on 07/13/11.
//
//	This code is distributed under the terms of the MIT license.
//
//	Copyright (c) 2011-2014 Steve Caine.
//

#ifdef	DEBUG
#define USECUSTOMLOGS 1
#endif

#ifdef __cplusplus
extern "C" {
#endif
	// C/C++
	// ----------------------------------------------------------------------
	const char* d_Nhex(const void* p, int n, bool treatAsText);
	const char* dd_Nhex(const void* data, int len);
	// ----------------------------------------------------------------------
	
#ifdef __OBJC__
	// Objective C/Cocoa Touch
	// ----------------------------------------------------------------------
	NSString *str_AppName();
	NSString *str_AppDisplayName();
	NSString *str_iOS_version();
	NSString *str_device_OS_UDID();
	// ----------------------------------------------------------------------
	NSString *str_AppPath();
	NSString *str_DocumentsPath();
	NSString *str_CachePath();
	// ----------------------------------------------------------------------
	NSString *str_logTime(NSDate *date); // '09:28:38 AM'
	NSString *str_logDate(NSDate *date); // '01 Jun 2014'
	// ----------------------------------------------------------------------
	NSString *str_AppState(UIApplicationState state);
	NSString *str_curAppState();
	// ----------------------------------------------------------------------
	NSString *str_CGPoint(CGPoint p);
	NSString *str_CGSize(CGSize s);
	NSString *str_CGRect(CGRect r);
	// ----------------------------------------------------------------------
	void tint_visibleCellsInTableView(UITableView *tableView);
	// ----------------------------------------------------------------------
	
#if USECUSTOMLOGS
#define NSLog MyLog
	// ----------------------------------------------------------------------
	void MyLog(NSString *format, ...);
	// ----------------------------------------------------------------------
	void d_AppState(UIApplicationState state, NSString *label);
	void d_curAppState(NSString *label);
	// ----------------------------------------------------------------------
	void d_CGPoint(CGPoint p, NSString *label);
	void d_CGSize(CGSize s, NSString *label);
	void d_CGRect(CGRect r, NSString *label);
	// ----------------------------------------------------------------------
	void log_visibleCellsInTableView(UITableView *tableView);
	// ----------------------------------------------------------------------
#else
#define MyLog(format, ...)
#define d_AppState(s, label)
#define d_curAppState(label)
#define d_CGPoint(p, label)
#define d_CGSize(s, label)
#define d_CGRect(r, label)
#define log_visibleCellsInTableView(tableView)
#endif // #if USECUSTOMLOGS
	
#endif // #ifdef __OBJC__
	
#ifdef __cplusplus
}
#endif
