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
#import <manual/cppInterface.h>
#import <manual/muxInterface.h>
#import <abcUniTemplate/abcUniTemplate.h>
#import <frameA/frameA.h>


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
    NSLog(@"manual say: ---");
    manual_say_hello(); // oc
    manual_say_hello_by_c(); // pure c
    manual_say_mux_oc(); // mux
    manual_say_mux_c(); // mux
    NSLog(@"manual say: ---");
    
    // test template
    template_say_hello();
    NSLog(@"template add: 3 + 6 = %d", template_add(3, 6));
    
    // test Framework -> Framework
    NSLog(@"framework minus: 8 - 6 = %d", frame_a_minux(8, 6));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
