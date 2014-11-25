# NSString * 和 NSString *const的区别

<!-- create time: 2014-11-20 16:41:20  -->
转自[any2mobile的NSString *到NSString *const的区别](http://blog.csdn.net/any2mobile/article/details/7291726)

    从NSString *到NSString *const的区别在于，
    NSString *值的指针可以改变指向（虽然不能改变内容，但是对于系统常量来说还是非常危险啊，这应该算是设计缺陷了，所以MacOS 10.6修改过来了），
    NSString *const的就是无论内容，指向都不能改了。
    类似于C++中const *及 const * const的区别。
    
    在.h声明NSString *const
    在.m中实现方法中进行赋值。
    
    Demo.h-－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
    #import <Foundation/Foundation.h>
    extern NSString *const Demo1; //extern全局声明
    extern NSString *const Demo2;
    @interface Demo : NSObject
    @end
    
    Demo.m－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
    #import "Demo.h"
    @implementation NotificationTools
    NSString *const Demo1 = @"This is Demo1";
    NSString *const Demo2 = @"This is Demo2";
    @end
    封装性

