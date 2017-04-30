//
//	Debug_iOS.m
//	DebugUtil
//
//	Created by Steve Caine on 07/12/14.
//	Split into separate Obj-C and UIKit files on 04/27/17.
//
//	This code is distributed under the terms of the MIT license.
//
//	Copyright (c) 2011-2017 Steve Caine.
//

#import "Debug_iOS.h"

#import <objc/runtime.h>

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
	UIApplication *app = UIApplication.sharedApplication;
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
	NSArray *visibleCells = tableView.visibleCells;
	if (visibleCells.count) {
		UITableViewCell *firstCell = [visibleCells objectAtIndex:0];
		UITableViewCell	 *lastCell = [visibleCells objectAtIndex:visibleCells.count - 1];
		firstCell.contentView.backgroundColor = [UIColor.blueColor colorWithAlphaComponent:0.25];
		lastCell.contentView.backgroundColor = [UIColor.greenColor colorWithAlphaComponent:0.25];
	}
}

// ----------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------
#if USECUSTOMLOGS
// ----------------------------------------------------------------------

void d_AppState(UIApplicationState state, NSString *label) {
	MyLog(@"%@%@", label, str_AppState(state));
}

void d_curAppState(NSString *label) {
	UIApplication *app = UIApplication.sharedApplication;
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
	if (visibleRows.count) {
		NSIndexPath *firstPath = [visibleRows objectAtIndex:0];
		NSIndexPath	 *lastPath = [visibleRows objectAtIndex:visibleRows.count - 1];
		MyLog(@" FIRST VISIBLE ROW at [%li:%li]", firstPath.section, firstPath.row);
		MyLog(@"  LAST VISIBLE ROW at [%li:%li]",  lastPath.section,  lastPath.row);
	}
}

// ----------------------------------------------------------------------
#endif // #if USECUSTOMLOGS
// ----------------------------------------------------------------------
