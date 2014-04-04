//
//  StaticTableViewController.h
//  StaticTable
//
//  Created by Neil Smyth on 9/17/13.
//  Copyright (c) 2013 Neil Smyth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StaticTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *carMakeLabel;
@property (weak, nonatomic) IBOutlet UILabel *carModelLabel;
@property (weak, nonatomic) IBOutlet UIImageView *carImageView;

@property (strong, nonatomic) NSArray *carDetailModel;


@end
