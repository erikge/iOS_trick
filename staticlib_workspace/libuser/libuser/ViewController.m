//
//  ViewController.m
//  libuser
//
//  Created by erikge on 13-12-2.
//  Copyright (c) 2013年 erikge. All rights reserved.
//

#import "ViewController.h"
#import <SayHi/say_hi.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    say_hi();
    say_bye();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
