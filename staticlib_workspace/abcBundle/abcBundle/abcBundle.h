//
//  abcBundle.h
//  abcBundle
//
//  Created by erikge on 13-12-23.
//  Copyright (c) 2013年 self. All rights reserved.
//

#ifndef abcBundle_abcBundle_h
#define abcBundle_abcBundle_h

/**
 * 通过修改 OS X -> Bundle工程模板创建 Framework
 * 本工程创建的frame不是模拟器、真机统一的
 
 Steps:
 1. Build Settings
    Base SDK 改为 Latest iOS
    Dead Code Stripping设置为NO
    Mach-O Type 为Relocatable Object File或者Static Library
    Link With Standard Libraries为NO
    Wrapper Extension修改为：默认的bundle改成framework
    Deployment 下OS X Deployment Target，将类似“OS X 10.9”改为”Compiler Default”
    Targeted Device Family改为需要的，此处改成了”iPhone/iPad”
 2. 预编译头全部注释掉
    abcBundle-Prefix.pch中的import注释掉
 3. Build Phases中添加Copy Headers，按需要copy头文件
 
 note: 貌似编译出来的模拟器库也可以在真机上跑。
    --其实是不行的，user工程（main）和库工程在一个工作空间时，貌似会自动编译对应device或simulator的库，而且貌似优先从工作空间中去链接
 */

#ifdef __cplusplus
extern "C" {
#endif

int bundle_add(int x, int y);
    
#ifdef __cplusplus
}
#endif


#endif
