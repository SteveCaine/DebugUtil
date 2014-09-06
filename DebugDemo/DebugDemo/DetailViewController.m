//
//	DetailViewController.m
//	DebugDemo
//
//	Created by Steve Caine on 07/12/14.
//
//	This code is distributed under the terms of the MIT license.
//
//	Copyright (c) 2014 Steve Caine.
//

#import "DetailViewController.h"

#import "Debug_iOS.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
	if (_detailItem != newDetailItem) {
		_detailItem = newDetailItem;
		
		// Update the view.
		[self configureView];
	}
}

- (void)configureView {
	// Update the user interface for the detail item.

	if (self.detailItem) {
		self.detailDescriptionLabel.text = [self.detailItem description];
	}
}

- (void)viewDidLoad {
	MyLog(@"\n%s", __FUNCTION__);
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self configureView];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
