//
//  muxInterface.m
//  abcUniManual
//
//  Created by VCTL on 13-12-24.
//  Copyright (c) 2013年 self. All rights reserved.
//

#import "muxInterface.h"
#include <iostream>

@implementation muxInterface

@end


void manual_say_mux_c() {
    std::cout << "manual mux say: Hello World -by std::cout" << std::endl;
}

void manual_say_mux_oc() {
    NSLog(@"manual mux say: Hello World -by NSLog");
}