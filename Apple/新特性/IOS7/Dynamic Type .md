# Dynamic Type 

<!-- create time: 2014-11-23 22:57:17  -->

    Dynamic Type最初由iOS 7引入，允许用户自定义文本大小从而满足app的需要。
    不过仅有采用Dynamic Type的app才能响应文本的改变，可能只有一小部分第三方应用使用了该功能。
    
    从iOS 8开始，苹果想要鼓励开发者使用Dynamic Type。
    正如在WWDC session中提到的那样，所有苹果系统级应用都使用了Dynamic Type，并且内置的标签已经有了动态字体。当用户改变文本大小时，这些标签也会改变其大小。
    
    更进一步说，Self Sizing Cell的引入是促进Dynamic Type使用的办法，它可以节省大量写代码调整行高的时间。如果单元格可以自动调整了，那么使用Dynamic Type就很显而易见了。
    
    你只需要从尺寸固定的自定义字体中将字体更改为文本类型（比如标题和内容主体）首选的字体。也就是说当你运行app时，它会适应文本大小的改变。

    获取字体改变的通知 UIContentSizeCategoryDidChangeNotification
    
    当字体改变时，可以方法刷新界面
