target说明：
lib-outof-workspace：标准iOS lib库，未封装成framework
lib-outof-workspaceTests：标准unit test，单元测试工程
SayHi：通过源码直接编译framework库，但.a库是没合并过的
merge2libs：合并真机、模拟器的.a库
uniSay：用merge2lib合并的库创建framework，依赖merge2libs，手动创建工程的方法
finalUni：另一种创建真机、模拟器通用framework的方法，独立target，不依赖别的target，手动创建工程的方法
finalUniByTemplate：通过 kstenerud / iOS-Universal-Framework 模板创建通用framework。
    构建方法：
    选择target > iOS device
    Product->Archive
