//
//	DetailViewController.h
//	Demo_dout
//
//	This code is distributed under the terms of the MIT license.
//
//	Copyright (c) 2014 Steve Caine.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
