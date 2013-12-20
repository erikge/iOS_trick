//
//  ViewController.m
//  ui
//
//  Created by VCTL on 13-12-17.
//  Copyright (c) 2013年 erikge. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)convertTemperature:(id)sender {
    double fahrenheit = [_temperatureInput.text doubleValue];
    _temperatureInput.text = [NSString stringWithFormat:@"%f", fahrenheit];
    double celsius = (fahrenheit - 32) / 1.8;
    
    NSString *resultString = [[NSString alloc]
                              initWithFormat: @"Celsius %f", celsius];
    _convertLabel.text = resultString;

}

- (IBAction)hintReturn:(id)sender {
    [sender resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([_temperatureInput isFirstResponder] && [touch view] != _temperatureInput) {
        [_temperatureInput resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}



@end
