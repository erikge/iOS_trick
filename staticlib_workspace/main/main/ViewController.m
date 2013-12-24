//
//  ViewController.m
//  main
//
//  Created by erikge on 13-12-23.
//  Copyright (c) 2013年 self. All rights reserved.
//

#import "ViewController.h"
#import <abcBundle/abcBundle.h>
#import <manual/abcUniManual.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // test bundle
    NSLog(@"bundle add: 3 + 2 = %d", bundle_add(3, 2));
    
    // test manual
    NSLog(@"manual say: --");
    manual_say_hello();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
