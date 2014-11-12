// from sample code in Chapter 7 of book "More iPhone 3 Development"
// (c) 2009 Dave Mark and Jeff LaMarche
// published by Apress Media LLC

#import <Foundation/Foundation.h>

@interface NSArray(NestedArrays)
/**
 This method will return an object contained with an array 
 contained within this array. It is intended to allow 
 single-step retrieval of objects in the nested array 
 using an index path
 */
- (id)nestedObjectAtIndexPath:(NSIndexPath *)indexPath;

/**
 This method will return the count from a subarray.
 */
- (NSInteger)countOfNestedArray:(NSUInteger)section;
@end
