//
//	MasterViewController.m
//	DebugDemo
//
//	Created by Steve Caine on 07/12/14.
//
//	This code is distributed under the terms of the MIT license.
//
//	Copyright (c) 2014 Steve Caine.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "Debug_iOS.h"

@interface MasterViewController () {
	NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib {
	[super awakeFromNib];
}

- (void)viewDidLoad {
//	MyLog(@"\n%s", __FUNCTION__);
	MyLog(@"\n%s for iOS %@\n", __FUNCTION__, str_iOS_version());
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.navigationItem.leftBarButtonItem = self.editButtonItem;

	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
	self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
	MyLog(@"\n%s", __FUNCTION__);
	if (!_objects) {
		_objects = [[NSMutableArray alloc] init];
	}
//	[_objects insertObject:NSDate.date atIndex:0];
	NSDate *now = NSDate.date;
	MyLog(@" adding row for date '%@'", now);
	[_objects insertObject:now atIndex:0];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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
	cell.textLabel.text = object.description;
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	// Return NO if you do not want the specified item to be editable.
	return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[_objects removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
	} else if (editingStyle == UITableViewCellEditingStyleInsert) {
		// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
	}
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
	MyLog(@"\n%s '%@'", __FUNCTION__, segue.identifier);
	if ([segue.identifier isEqualToString:@"showDetail"]) {
		
		// SPC 07-12-14 set 'back' button title to something short
		self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Master" style:UIBarButtonItemStylePlain target:nil action:nil ];
		
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		NSDate *object = _objects[indexPath.row];
		[segue.destinationViewController setDetailItem:object];
	}
}

@end
