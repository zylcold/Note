# Modules

<!-- create time: 2014-12-10 00:57:06  -->

转自[iOS7中Objective-C和Foundation的新特性](http://my.oschina.net/u/248165/blog/224319)

原文[What’s New in Objective-C and Foundation in iOS 7](http://www.raywenderlich.com/49850/whats-new-in-objective-c-and-foundation-in-ios-7)

    
    Modules封装框架比以往任何时候更加清洁。不再需要预处理逐行地用文件所有内容替换#import指令。相反，一个模块包含了一个框架到自包含的块 中，就像PCH文件预编译的方式一样提升了编译速度。并且你不需要在PCH文件中声明你要用到哪些框架，使用Modules简单的获得了速度上的提升。

     Modules的使用相当简单。对于存在的工程，第一件事情就是使这个功能生效。你可以在项目的Build Settings通过搜索Modules找到这个选项，改变Enable Modules 选项为YES

     所有的新工程都是默认开启这个功能的，但是你应该在你所有存在的工程内都开启这个功能。

    Link Frameworks Automatically选项可以用来开启或者关闭自动连接框架的功能，就像描述的那么简单。还是有一点原因的为什么你会想要关闭这个功能。

    一旦Modules功能开启，你就可以在你的代码中使用它了。像这样做，对以前用到的语法有一点小小的改动。用@import代替#import

    例如你只想要导入UIView，你就这样写：
    
    @import UIKit.UIView; 
    
    技术上，你不需要把所有的#import都换成@import ，因为编译器会隐式的转换他们。
    
    Xcode5的Modules还不支持你自己的或者第三方的框架。
