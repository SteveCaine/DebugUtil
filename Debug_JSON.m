//
//	Debug_JSON.m
//	version 0.0
//
//	Created by Steve Caine on 08/01/14.
//  Copyright (c) 2014 Steve Caine. All rights reserved.
//

#define CONFIG_justTypes 1

#import "Debug_JSON.h"

#import "Debug_iOS.h"

// ----------------------------------------------------------------------
#pragma mark - locals
// ----------------------------------------------------------------------
static const unichar tabs[] = {'\t','\t','\t','\t','\t'};
static const int num_tabs = sizeof(tabs)/sizeof(tabs[0]);

static const unichar spaces[] = {' ',' ',' ',' ',' ',' ',' '};
static const int num_spaces = sizeof(spaces)/sizeof(spaces[0]);

static NSString *str_indent(NSUInteger deep, const unichar *buffer, NSUInteger len) {
	NSMutableString *result = [NSMutableString stringWithCapacity:deep];
	while (deep > 0) {
		NSUInteger num = deep;
		if (num > len)
			num = len;
		[result appendString:[NSString stringWithCharacters:buffer length:num]];
		deep -= num;
	}
	return result;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"

	static NSString *str_tabs(NSUInteger deep) { // str_tabs() not used - yet
		return str_indent(deep, tabs, num_tabs);
	}
	// returns mutable string of -deep- spaces
	static NSString *str_spaces(NSUInteger deep) {
		return str_indent(deep, spaces, num_spaces);
	}

#pragma clang diagnostic pop// returns mutable string of -deep- tabs

static void str_types_tree(id node, NSMutableString *append, NSUInteger deep) {
	if (node != nil /*&& append != nil*/ && [append isKindOfClass:[NSMutableString class]]) {
//		NSString *indent = str_tabs(deep);
		NSString *indent = str_spaces(2 * deep); // 2 spaces per level
		
		// this level is ...
		NSString *str_class = NSStringFromClass([node class]);
//		MyLog(@"%@class = %@", indent, str_class);
//		[append appendFormat:@"%@%@\n", indent, str_class];
		
		// next level is ...
		if ([node isKindOfClass:[NSArray class]]) {
			[append appendFormat:@"%@%@[%i]\n", indent, str_class, (int)[(NSArray *)node count]];
			for (id subnode in (NSArray *)node) {
				str_types_tree(subnode, append, 1+deep);
			}
		}
		else if ([node isKindOfClass:[NSDictionary class]]) {
			NSArray *keys = [(NSDictionary *)node allKeys];
			[append appendFormat:@"%@%@{%i}\n", indent, str_class, (int)[keys count]];
			for (NSString *key in keys) {
				id subnode = [(NSDictionary *)node objectForKey:key];
#if !CONFIG_justTypes
				[append appendFormat:@"key = '%@',",key];
#endif
				str_types_tree(subnode, append, 1+deep);
			}
		}
		// else no more levels here
		if ([node isKindOfClass:[NSString class]])
#if CONFIG_justTypes
			[append appendFormat:@"%@%@ = '%@'\n", indent, str_class, (NSString *)node];
#else
			[append appendFormat:@"%@%@ = '%@'\n", indent, @"val", (NSString *)node];
#endif
		else
			[append appendFormat:@"%@%@\n", indent, str_class];
	}
}

// ----------------------------------------------------------------------
#pragma mark - globals
// ----------------------------------------------------------------------

NSString *str_Json_types(id root) {
	NSMutableString *result = nil;
	if (root != nil) {
		result = [NSMutableString stringWithCapacity:0];
		str_types_tree(root, result, 0);
	}
	return result;
}

