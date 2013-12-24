//
//  abcUniTemplate.h
//  abcUniTemplate
//
//  Created by VCTL on 13-12-24.
//  Copyright (c) 2013年 erikge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface abcUniTemplate : NSObject

@end

/**
 * 通过 kstenerud / iOS-Universal-Framework 模板创建通用framework
 * Step:
    1. Fake Static iOS Framework
    2. Build Phase中添加要暴露的头文件
    3. 通过target > iOS device或者target > simulator运行Build或Run编译出来的不是真机、模拟器通用Framework，是单一Framework
    4. 选择target > iOS device，通过Product->Archive打包release版本的通用Framework
 */

void template_say_hello();
