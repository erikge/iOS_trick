target说明：
lib-outof-workspace：标准iOS lib库
lib-outof-workspaceTests：标准unit test
SayHi：通过源码直接编译framework库
merge2libs：合并真机、模拟器的.a库
uniSay：用merge2lib合并的库创建framework
finalUni：创建真机、模拟器通用framework
finalUniByTemplate：通过 kstenerud / iOS-Universal-Framework 模板创建通用framework。
    构建方法：
    选择target > iOS device
    Product->Archive
