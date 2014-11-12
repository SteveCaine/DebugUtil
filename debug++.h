/*
 *  debug++
 *
 *  generic debug-logging code for iOS development
 *
 *  lets you sprinkle "dout << "{string}" << *{data} << endl;" throughout your Objective-C++ files;
 *	they will only write to Xcode's debugger console when running the project's Debug configuration,
 *  they become no-ops in the Release configuration
 *
 *  TO USE: 
 *  define the preprocessor macro _DEBUG in your project's Debug configuration
 *  (Project > Target > Build Settings > Apple LLVM PreProcessing > Preprocessor Macros/GCC_PREPROCESSOR_DEFINITIONS)
 *
 *  Created by Steve Caine on 09/03/10.
 *
 *	This code is distributed under the terms of the MIT license.
 *
 *  Copyright 2010-2014 Steve Caine.
 *
 */

#define CONFIG_usingCoreData	0

#ifndef H_debug_pp
#define H_debug_pp
#pragma once

// ----------------------------------------------------------------------
#ifdef _DEBUG
	#include <iostream>
	namespace debugging {
		extern std::ostream& dout;
		using std::endl;
		using std::flush;
	}
#else
// ----------------------------------------------------------------------
namespace bitbucket {
	struct sink {
		inline sink& write(const void*, int) { return *this; }
		inline sink& flush() { return *this; }
	};
	extern sink dout;
	extern int endl;
	extern int flush;
	
	template <class T> inline
	const sink& operator<<(const sink& out, const T& data) { return out; }
}
#endif
// ----------------------------------------------------------------------
#ifdef _DEBUG
	using namespace debugging;
#else
	using namespace bitbucket;
#endif
// ----------------------------------------------------------------------

class StFuncLogger { // use: StFuncLogger log(__FUNCTION__);
	//private:
	static int d_deep;
	const char* m_str;
public:
	StFuncLogger(const char* str, bool writeCR = true);
	~StFuncLogger();
};

// ----------------------------------------------------------------------

#ifdef _DEBUG
// ----------------------------------------------------------------------
#include <iostream>
// ----------------------------------------------------------------------
std::ostream& operator<<(std::ostream& out, const CGPoint& point);

std::ostream& operator<<(std::ostream& out, const CGSize& size);

std::ostream& operator<<(std::ostream& out, const CGRect& rect);

std::ostream& operator<<(std::ostream& out, const UIDeviceOrientation& o);

std::ostream& operator<<(std::ostream& out, const UIInterfaceOrientation& o);

std::ostream& operator<<(std::ostream& out, const CGAffineTransform& t);


std::ostream& operator<<(std::ostream& out, const NSString& s);

std::ostream& operator<<(std::ostream& out, const NSDate& d);

std::ostream& operator<<(std::ostream& out, const NSArray& a);


std::ostream& operator<<(std::ostream& out, const NSIndexPath& ip);

std::ostream& operator<<(std::ostream& out, const UITableView& tb);

std::ostream& operator<<(std::ostream& out, const UITableViewCellEditingStyle& es);

std::ostream& operator<<(std::ostream& out, const NSDictionary& d);

#endif

// ----------------------------------------------------------------------
// NestedArray is a category on NSArray to help manage the content of table views
// where each element in the array is an array itself;
// the top array represents sections in the table.
// each nested array represents rows in that secton

// this struct is used to 'wrap' such an array so we can define
// an ostream<< operator to write its contents to std::cout
typedef struct dNestedArray {
	NSArray *_na;
	dNestedArray(NSArray *na) { _na = na; }
	dNestedArray() { _na = nil; }
} dNestedArray;

#ifdef _DEBUG
std::ostream& operator<<(std::ostream& out, const dNestedArray& dna);
#endif

// ----------------------------------------------------------------------
#if CONFIG_usingCoreData

#ifdef _DEBUG
std::ostream& operator<<(std::ostream& out, const NSFetchedResultsController& frc);
#endif

// this struct is used to wrap an enum so its value *name* can be writted to std::out
typedef struct dNSFetchedResultsChangeType {
	NSFetchedResultsChangeType _ct;
	dNSFetchedResultsChangeType(NSFetchedResultsChangeType ct) { _ct = ct; }
	dNSFetchedResultsChangeType() { _ct = -1; }
} dNSFetchedResultsChangeType;

#ifdef _DEBUG
std::ostream& operator<<(std::ostream& out, const dNSFetchedResultsChangeType& dct);
#endif

#endif // #if CONFIG_usingCoreData
// ----------------------------------------------------------------------

#endif // H_debug_pp
