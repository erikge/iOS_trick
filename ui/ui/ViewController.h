//
//  ViewController.h
//  ui
//
//  Created by VCTL on 13-12-17.
//  Copyright (c) 2013年 erikge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *temperatureInput;
@property (strong, nonatomic) IBOutlet UILabel *convertLabel;
- (IBAction)convertTemperature:(id)sender;
@end
