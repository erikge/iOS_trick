//
//  HideKeyboardViewController.h
//  HideKeyboard
//
//  Created by Neil Smyth on 9/17/13.
//  Copyright (c) 2013 Neil Smyth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HideKeyboardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textField;
-(IBAction)textFieldReturn:(id)sender;
@end
