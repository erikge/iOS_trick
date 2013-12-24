//
//  abcUniManual.h
//  abcUniManual
//
//  Created by erikge on 13-12-24.
//  Copyright (c) 2013年 self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface abcUniManual : NSObject

@end

/**
 * 使用苹果标准Cocoa Touch Static Library工程，
 * 然后通过shell脚本合并真机、模拟器库，创建Framework目录结构
 
 * 本工程同时示范引用stl库
 */

void manual_say_hello();
