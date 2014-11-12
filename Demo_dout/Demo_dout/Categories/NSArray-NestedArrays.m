// from sample code in Chapter 7 of book "More iPhone 3 Development"
// (c) 2009 Dave Mark and Jeff LaMarche
// published by Apress Media LLC

#import "NSArray-NestedArrays.h"

@implementation NSArray(NestedArrays)

- (id)nestedObjectAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
	NSUInteger section = [indexPath section];
	NSArray *subArray = [self objectAtIndex:section];
	
	if (![subArray isKindOfClass:[NSArray class]])
		return nil;
	
	if (row >= [subArray count])
		return nil;
	
	return [subArray objectAtIndex:row];
}

- (NSInteger)countOfNestedArray:(NSUInteger)section {
	NSArray *subArray = [self objectAtIndex:section];
	return [subArray count];
}

@end
