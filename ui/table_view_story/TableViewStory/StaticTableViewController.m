//
//  StaticTableViewController.m
//  StaticTable
//
//  Created by Neil Smyth on 9/17/13.
//  Copyright (c) 2013 Neil Smyth. All rights reserved.
//

#import "StaticTableViewController.h"

@interface StaticTableViewController ()

@end

@implementation StaticTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _carMakeLabel.text = _carDetailModel[0];
    _carModelLabel.text = _carDetailModel[1];
    _carImageView.image = [UIImage imageNamed:_carDetailModel[2]];

//    _carMakeLabel.text = @"Volvo";
//    _carModelLabel.text = @"S60";
//    _carImageView.image = [UIImage imageNamed:@"volvo_s60.jpg"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
