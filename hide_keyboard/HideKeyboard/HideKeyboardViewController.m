//
//  HideKeyboardViewController.m
//  HideKeyboard
//
//  Created by Neil Smyth on 9/17/13.
//  Copyright (c) 2013 Neil Smyth. All rights reserved.
//

#import "HideKeyboardViewController.h"

@interface HideKeyboardViewController ()

@end

@implementation HideKeyboardViewController

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

// [erik] begin
-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}
// [erik] end

// [erik] begin
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[event allTouches] anyObject];
    if ([_textField isFirstResponder] && [touch view] != _textField) {
        [_textField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}
// [erik] end

@end
