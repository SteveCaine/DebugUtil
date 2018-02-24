/*
 *  debug++
 *
 *  see description in header file
 *
 *  Created by Steve Caine on 09/03/10.
 *
 *	This code is distributed under the terms of the MIT license.
 *
 *  Copyright 2010-2014 Steve Caine.
 *
 */

#include "debug++.h"

// ----------------------------------------------------------------------
#ifdef _DEBUG
	namespace debugging {
		std::ostream& dout = std::cout;
	}
#else
	bitbucket::sink bitbucket::dout;
	int bitbucket::endl;
	int bitbucket::flush;
#endif
// ----------------------------------------------------------------------

// ----------------------------------------------------------------------
StFuncLogger::StFuncLogger(const char* str, bool writeCR /*= true*/)
: m_str(str) 
{
#ifdef _DEBUG
	if (m_str) { 
		int deep = ++d_deep; while (deep-- > 0) dout << '\t'; 
		dout << "=>" << m_str; 
		if (writeCR) dout << endl; 
	}
#endif
}

StFuncLogger::~StFuncLogger()
{
#ifdef _DEBUG
	if (m_str) { 
		int deep = d_deep--; while (deep-- > 0) dout << '\t'; 
		dout << "<=" << m_str << endl; // << endl;
	}
#endif
}
int StFuncLogger::d_deep = -1;

#ifdef __OBJC__
#ifdef UIKIT_EXTERN
// ----------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------
// for dout << UITableView
@interface UITableView (UITableViewPeek)
- (NSInteger) totalRowCount;
@end
// ----------------------------------------------------------------------
@implementation UITableView (UITableViewPeek)
- (NSInteger) totalRowCount {
	NSInteger result = 0;
	NSInteger sections = [self numberOfSections];
	for (NSInteger s = 0; s < sections; ++s)
		result += [self numberOfRowsInSection:s];
	return result;
}
@end
// ----------------------------------------------------------------------

#ifdef _DEBUG
// ----------------------------------------------------------------------
#pragma mark - structs
// ----------------------------------------------------------------------

std::ostream& operator<<(std::ostream& out, const CGPoint& point) {
	out << point.x << ", " << point.y;
	out << " (x,y)";
	return out;	
}

// ----------------------------------------------------------------------
std::ostream& operator<<(std::ostream& out, const CGSize& size)
{
	out << size.width << " " << size.height;
	out << " (width height)";
	return out;
}
// ----------------------------------------------------------------------

std::ostream& operator<<(std::ostream& out, const CGRect& rect) {
//	out << rect.origin.y << ", " << rect.origin.x << ", ";
//	out << rect.origin.y + rect.size.height << ", " << rect.origin.x + rect.size.width;
//	out << " (top,left,bottom,right)";
	out << rect.origin.x << " " << rect.origin.y << "; ";
	out << rect.size.width << " " << rect.size.height;
	out << " (x y; width height)";
	return out;
}

// ----------------------------------------------------------------------
#pragma mark - enums
// ----------------------------------------------------------------------

std::ostream& operator<<(std::ostream& out, const UIDeviceOrientation& o) {
	switch (o) {
		case UIDeviceOrientationUnknown:			out << "?";					break;
		case UIDeviceOrientationPortrait:			out << "portrait up";		break; // Device oriented vertically, home button on the bottom
		case UIDeviceOrientationPortraitUpsideDown:	out << "portrait down";		break; // Device oriented vertically, home button on the top
		case UIDeviceOrientationLandscapeLeft:		out << "landscape left";	break; // Device oriented horizontally, home button on the right
		case UIDeviceOrientationLandscapeRight:		out << "landscape right";	break; // Device oriented horizontally, home button on the left
		case UIDeviceOrientationFaceUp:				out << "face-up";			break; // Device oriented flat, face up
		case UIDeviceOrientationFaceDown:			out << "face-down";			break; // Device oriented flat, face down
		default: out << "???"; break;
	}
	return out;
}

// ----------------------------------------------------------------------

// Note that UIInterfaceOrientationLandscapeLeft is equal to UIDeviceOrientationLandscapeRight (and vice versa).
// This is because rotating the device to the left requires rotating the content to the right.
std::ostream& operator<<(std::ostream& out, const UIInterfaceOrientation& o) {
	switch (o) {
		case UIInterfaceOrientationPortrait:			out << "portrait up";		break; // interface oriented vertically, home button on the bottom
		case UIInterfaceOrientationPortraitUpsideDown:	out << "portrait down";		break; // interface oriented vertically, home button on the top
		case UIInterfaceOrientationLandscapeLeft:		out << "landscape right";	break; // interface oriented horizontally, home button on the right
		case UIInterfaceOrientationLandscapeRight:		out << "landscape left";	break; // interface oriented horizontally, home button on the left
		default: out << "???"; break;
	}
	return out;
}

// ----------------------------------------------------------------------

std::ostream& operator<<(std::ostream& out, const CGAffineTransform& t)
{
	if (CGAffineTransformIsIdentity(t))
		out << "CGAffineTransformIdentity" << endl;
	else {
		out << "[  a,  b, 0 ] = " << t.a <<  ", " << t.b << endl;
		out << "[  c,  d, 0 ] = " << t.c <<  ", " << t.d << endl;
		out << "[ tx, ty, 1 ] = " << t.tx << ", " << t.ty << endl;
	}
	return out;
}

// ----------------------------------------------------------------------
#pragma mark - objects
// ----------------------------------------------------------------------

std::ostream& operator<<(std::ostream& out, const NSString& s) {
	if (const NSString *p = &s)
		out << [p UTF8String];
	else 
		out << "p=nil";
	return out;
}

// ----------------------------------------------------------------------

std::ostream& operator<<(std::ostream& out, const NSDate& d) {
	if (const NSDate * p = &d) {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterMediumStyle];
		[formatter setTimeStyle:NSDateFormatterMediumStyle];
		NSString *dateStr = [formatter stringFromDate:[p copy]]; // need non-const object for parameter
#if !__has_feature(objc_arc)
		[formatter release];
#endif
		out << *dateStr;
	}
	else 
		out << "p=nil";
	return out;
}

// ----------------------------------------------------------------------

std::ostream& operator<<(std::ostream& out, const NSArray& a) {
	if (const NSArray *p = &a) {
		int i = 0;
		for (NSObject *o in p) 
			NSLog(@"%2i: %@", i, o);
	}
	else 
		out << "p=nil";
	return out;
}

// ----------------------------------------------------------------------
#pragma mark - tables
// ----------------------------------------------------------------------

std::ostream& operator<<(std::ostream& out, const NSIndexPath& ip) {
	if (const NSIndexPath *p = &ip)
		out << p.section << ":" << p.row; //<< " (section:row)";
	else 
		out << "p=nil";
	return out;
}

// ----------------------------------------------------------------------

std::ostream& operator<<(std::ostream& out, const UITableView& tb) {
	if (const UITableView *p = &tb) {
		NSUInteger sections = [p numberOfSections];
		out << sections << " section(s)" << " and " << [p totalRowCount] << " row(s)" << endl;
		for (NSUInteger s = 0; s < sections; ++s) {
			NSUInteger rows = [p numberOfRowsInSection:s];
			out << " section " << s << " has " << rows << " rows" << endl;
			for (NSUInteger r = 0; r < rows; ++r) {
				if (r) dout << endl;
				out << s << ":" << r; //<< endl;
				NSUInteger s_r[] = { s, r };
				NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:s_r length:2];
				if (UITableViewCell *cell = [p cellForRowAtIndexPath:indexPath]) {
//NSLog(@"cell: %@", cell);
if (cell.textLabel)       dout << " - '" << *cell.textLabel.text << "'";
if (cell.detailTextLabel) dout << " ('" << *cell.detailTextLabel.text << "')";
			}
//				dout << endl;
			}
		}
	}
	else 
		out << "p=nil";
	return out;
}

// ----------------------------------------------------------------------

std::ostream& operator<<(std::ostream& out, const UITableViewCellEditingStyle& es) {
	switch (es) {
		case UITableViewCellEditingStyleNone:	out << "UITableViewCellEditingStyleNone";	break;
		case UITableViewCellEditingStyleDelete:	out << "UITableViewCellEditingStyleDelete";	break;
		case UITableViewCellEditingStyleInsert:	out << "UITableViewCellEditingStyleInsert";	break;
		default: out << "???"; break;
	}
	return out;
}

// ----------------------------------------------------------------------

std::ostream& operator<<(std::ostream& out, const NSDictionary& d) {
	if (const NSDictionary *p = &d) {
		if (NSArray *keys = [p allKeys]) {
			NSInteger i = 0;
			for (NSString *key in keys) {
				if (i)
					dout << endl;
				dout << i++ << ": " << *key << " = ";
				if (NSObject *val = [p valueForKey:key])
					dout << "'" << *[val description] << "'";
				else 
					dout << "nil";
			}
		}
	}
	else 
		out << "p=nil";
	return out;
}

// ----------------------------------------------------------------------
#pragma mark - custom object wrappers
// ----------------------------------------------------------------------
std::ostream& operator<<(std::ostream& out, const dNestedArray& dna) {
	if (NSArray *p = dna._na) {
		NSInteger sections = [p count];
		dout << "sections = " << sections << endl;
		for (NSInteger s = 0; s < sections; ++s) {
			NSArray *rowArray = [p objectAtIndex:s];
			if (rowArray != nil && [rowArray isKindOfClass:[NSArray class]]) {
				NSInteger rows = [rowArray count];
				dout << "rows = " << rows << " in section " << s << endl;
				for (NSInteger r = 0; r < rows; ++r) {
					dout << s << ":" << r << " = ";
					id obj = [rowArray objectAtIndex:r];
					if (obj == nil)
						dout << "nil" << endl;
//					else if (obj == [NSNull null])
//						dout << "NSNull null";
					else if ([obj isKindOfClass:[NSString class]])
						dout << "'" << *(NSString*) obj << "' (string)";
					else if ([obj isKindOfClass:[NSDictionary class]])
						dout << "NSDictionary";
					else if ([obj isKindOfClass:[NSArray class]])
						dout << "NSArray";
					else
						dout << *[obj description];
					dout << endl;
				}
			}
			else
				dout << " rowArray is " << *[rowArray description] << endl;
		}
	}
	else
		out << "p=nil";
	return out;
	
}

// ----------------------------------------------------------------------
#pragma mark - Core Data
// ----------------------------------------------------------------------
#if CONFIG_usingCoreData

std::ostream& operator<<(std::ostream& out, const NSFetchedResultsController& frc) {
	if (const NSFetchedResultsController *p = &frc) {
		NSArray *s = [p sections];
		NSArray *a = [p fetchedObjects];
		
		out << [s count] << " sections and " <<  [a count] << " objects" << endl;
		NSInteger i = 0;
		for (id <NSFetchedResultsSectionInfo> si in s) {
			dout << "section " << i++ << ": name = '" << *[si name] << "', title = '" << *[si indexTitle] << "', " << [si numberOfObjects] << " objects" << endl;
		}
		NSInteger j = 0;
		for (NSManagedObject* o in a) {
			dout << "{object " << j++ << ":";
#if 1  // SuperDB
			if (NSString* name = [o valueForKey:@"name"])
				dout << " '" << *name << "'";
			if (NSString *ident = [o valueForKey:@"secretIdentity"])
				dout << " ('"  << *ident << "')";
#else // DateSectionTitles
			if (NSString* title = [o valueForKey:@"title"])
				dout << " '" << *title << "'";
#endif
#if 1
			dout << endl;
			dout << "   saved: ";
			NSDictionary *saved = [o committedValuesForKeys:nil];
			if ([saved count])
				dout << endl << *saved;
			else
				dout << "none";
			dout << endl;
			
			dout << " unsaved: ";
			NSDictionary *unsaved = [o changedValues];
			if ([unsaved count])
				dout << endl << *unsaved;
			else
				dout << "none";
#endif
			dout << "}" << endl;
		}
	}
	else
		out << "p=nil";
	return out;
}

// ----------------------------------------------------------------------

std::ostream& operator<<(std::ostream& out, const dNSFetchedResultsChangeType& dct) {
	switch (dct._ct) {
		case NSFetchedResultsChangeInsert: out << "INSERT"; break;
		case NSFetchedResultsChangeDelete: out << "DELETE"; break;
		case NSFetchedResultsChangeMove:   out << "MOVE";   break;
		case NSFetchedResultsChangeUpdate: out << "UPDATE"; break;
		default: out << "FRC-???"; break;
	}
	return out;
}
#endif // #if CONFIG_usingCoreData
// ----------------------------------------------------------------------
#endif // #ifdef UIKIT_EXTERN
#endif // #ifdef __OBJC__
// ----------------------------------------------------------------------
#endif // #ifdef _DEBUG
// ----------------------------------------------------------------------
