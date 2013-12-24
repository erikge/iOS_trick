main：使用各种库的demo工程
all：用各种方式编译库

制作库的方式：
    1 .a + .h                   --> abcNormalA
    2 single Framework          --> abcBundle
    3 manual uni Framework      --> abcUniManual
    4 template uni Framework    --> abcUniTemplate
    
库之间的依赖关系
    1 Framework(abcUniManual)   --> system lib(libstdc++)
    2 Framework(abcUniTemplate) --> self lib(abcNormalA)
    3 Framework(abcFrmA)        --> self Framework(abcFrmB)