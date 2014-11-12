//
//	MasterViewController.mm
//	Demo_dout
//
//	This code is distributed under the terms of the MIT license.
//
//	Copyright (c) 2014 Steve Caine.
//

#define CONFIG_useNestedArrays	1

#import "MasterViewController.h"

#import "DetailViewController.h"

#include "debug++.h"

#import "NSArray-NestedArrays.h"


@interface MasterViewController () {
	NSMutableArray *_objects;
}
+ (void)method2;
@end



static void func1() {
	StFuncLogger log(__FUNCTION__);
	[MasterViewController method2];
}
static int func3() {
	int result = 3;
	StFuncLogger log(__FUNCTION__, false);
	dout << " returns '" << result << "'" << endl;
	return result;
}



@implementation MasterViewController

+ (void)method2 {
	StFuncLogger log(__FUNCTION__);
	func3();
}

- (void)awakeFromNib {
	[super awakeFromNib];
}

- (void)viewDidLoad {
	StFuncLogger log(__FUNCTION__);
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
	self.navigationItem.rightBarButtonItem = addButton;
	
	func1();
	
	NSArray *data = @[
					  @[@"one",@"two",@"three"],
					  @[@"uno",@"dos",@"tres"],
					  @[@"un",@"deux",@"trois"]
					  ];
	dout << " data = " << *data << " = " << dNestedArray(data) << endl;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
	if (!_objects) {
		_objects = [[NSMutableArray alloc] init];
	}
	NSDate *object = [NSDate date];
	
	StFuncLogger log(__FUNCTION__, false);
	dout << " - adding " << *object << endl;
	
	[_objects insertObject:object atIndex:0];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
	
	dout << " now table has " << *self.tableView << endl;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	NSDate *object = _objects[indexPath.row];
	cell.textLabel.text = [object description];
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	// Return NO if you do not want the specified item to be editable.
	return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	StFuncLogger log(__FUNCTION__, false);
	dout << " style = '" << editingStyle << "' on cell [" << *indexPath << "]" << endl;
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[_objects removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
	} else if (editingStyle == UITableViewCellEditingStyleInsert) {
		// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
	}
	dout << " now table has " << *self.tableView << endl;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	// Return NO if you do not want the item to be re-orderable.
	return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([[segue identifier] isEqualToString:@"showDetail"]) {
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		NSDate *object = _objects[indexPath.row];
		
		StFuncLogger log(__FUNCTION__,false);
		dout << " - pushing " << *object << endl;
		
		[[segue destinationViewController] setDetailItem:object];
	}
}

@end
