隐藏键盘的技巧。

有两种需要隐藏弹出键盘的场景：
1、输入完毕，点击 return 的时候。
    这个貌似 iOS 7 以后已经自动实现了。
    
2、输入完毕，点击输入框外部的背景部分。
    iOS未实现，需要自己实现。
    
    
自己实现的方法：
1、return 隐藏
    1.1 关联 TextField 的 Did End on Exit 事件的Action
    2.2 在 Action 中调用 [sender resignFirstResponder]; 实现

2、点击背景隐藏
    2.1 实现 view controller 的 touchesBegan 方法


PS: 在代码中搜索 [erik] 查看相关代码。
