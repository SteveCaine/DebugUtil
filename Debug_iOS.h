//
//	Debug_iOS.h
//	DebugUtil
//
//	Supplement to 'Debug_ObjC' adding debug logging for files using UIKit headers
//
//	Created by Steve Caine on 07/13/11.
//	Split into separate Obj-C and UIKit files on 04/27/17.
//
//	This code is distributed under the terms of the MIT license.
//
//	Copyright (c) 2011-2017 Steve Caine.
//

#import <UIKit/UIKit.h>

#import "Debug_ObjC.h"

// ----------------------------------------------------------------------
NSString *str_AppState(UIApplicationState state);
NSString *str_curAppState(void);
// ----------------------------------------------------------------------
NSString *str_CGPoint(CGPoint p);
NSString *str_CGSize(CGSize s);
NSString *str_CGRect(CGRect r);
// ----------------------------------------------------------------------
void tint_visibleCellsInTableView(UITableView *tableView);
// ----------------------------------------------------------------------

// ----------------------------------------------------------------------
#if USECUSTOMLOGS
// ----------------------------------------------------------------------

// ----------------------------------------------------------------------
void d_AppState(UIApplicationState state, NSString *label);
void d_curAppState(NSString *label);
// ----------------------------------------------------------------------
void d_CGPoint(CGPoint p, NSString *label);
void d_CGSize(CGSize s, NSString *label);
void d_CGRect(CGRect r, NSString *label);
// ----------------------------------------------------------------------
void log_visibleRowsInTableView(UITableView *tableView);
// ----------------------------------------------------------------------
#else
// ----------------------------------------------------------------------
#define d_AppState(s, label)
#define d_curAppState(label)
#define d_CGPoint(p, label)
#define d_CGSize(s, label)
#define d_CGRect(r, label)
#define log_visibleCellsInTableView(tableView)
// ----------------------------------------------------------------------
#endif // #if USECUSTOMLOGS
// ----------------------------------------------------------------------
