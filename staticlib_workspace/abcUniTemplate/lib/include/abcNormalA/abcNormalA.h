//
//  abcNormalA.h
//  abcNormalA
//
//  Created by erikge on 13-12-23.
//  Copyright (c) 2013年 self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface abcNormalA : NSObject

@end

/**
 * *.a和头文件形式
 * 苹果标准lib库模板
 
 * note: c的头文件注意extern C声明
 */

#ifdef __cplusplus
extern "C" {
#endif


int normal_add(int a, int b);

#ifdef __cplusplus
}
#endif
