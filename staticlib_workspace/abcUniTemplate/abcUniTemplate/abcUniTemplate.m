//
//  abcUniTemplate.m
//  abcUniTemplate
//
//  Created by VCTL on 13-12-24.
//  Copyright (c) 2013年 erikge. All rights reserved.
//

#import "abcUniTemplate.h"
#import "abcNormalA.h"

@implementation abcUniTemplate

@end

void template_say_hello() {
    NSLog(@"template say: hello world");
    //std::cout << "template say: hello world" << std::endl;
}

int template_add(int a, int b) {
    return normal_add(a, b);
}