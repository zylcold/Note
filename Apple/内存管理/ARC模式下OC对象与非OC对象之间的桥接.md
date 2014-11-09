# ARC模式下OC对象与非OC对象之间的桥接

<!-- create time: 2014-11-08 22:09:07  -->


        __bridge:不涉及对象所有关系改变
        __bridge_transfer:给予 ARC 所有权
        __bridge_retained:解除 ARC 所有权

转自[tlb203](http://www.cocoachina.com/bbs/read.php?tid=140786&fpage=32)        
        
在ARC中，OC对象与非OC对象在强制转换中，需要使用以上三个关键字进行桥接，那么三个关键字各用在什么情况下呢？详解如下：

下面一行代码：

      CFStringRef s1 = 
          (CFStringRef)[[NSString alloc] initWithFormat:@”Hello, %d!”, 1];

在ARC下面会报编译问题，并会给出推荐的解决方案：

    CFStringRef s1 = 
        (__bridge CFStringRef)[[NSString alloc] initWithFormat:@”Hello, %d!”, 1];
        
这里NSString生成的是OC的对象，内存由ARC负责。s1是CF的对象，内存还是需要自己手动管理。两个变量转换时需要添加桥接标识。

上面这种情况下不会crash，也不会有内存泄露。因为alloc出来的内存会被ARC回收，这块内存的所有关系没变。

如果后面加上CFRelease(s1);就会crash，因为这块内存还是归ARC管的，这样会过度释放。

修改一下：

    CFStringRef s1 = 
        (__bridge_retained CFStringRef)[[NSString alloc] initWithFormat:@”Hello, %d!”, 1];

这种情况下，对象的所有权交给CF对象了。就需要加上CFRelease(s1);进行释放，否则会产生泄露。

再看下面代码：

    CFUUIDRef uu = CFUUIDCreate(NULL);
    CFStringRef s2 = CFUUIDCreateString(NULL, uu);
    CFRelease(uu);
    NSString* str = (__bridge NSString*)s2;
    NSLog(@”STR:%@”,str);
    CFRelease(s2);
这里的uu和s2都需要使用CFRelease释放，因为他们不是OC对象，并且是create出来的内存，并且所有权没有被释放。

如果改动下面一行代码：

    NSString* str = (__bridge_transfer NSString*)s2;

这时候运行程序会引起crash，因为s2的所有权已经交给ARC中的str了，ARC会负责释放这块内存。

这时候调用CFRelease(s2);会造成过度释放。所以应该把这么行代给去了。

注：
ARC模式下，自动回收只针对Objective-C对象有效，对于使用create,copy,retain等生成的Core Foundation对象还是需要我们手动进行释放的，CFRelease().


[待整理](http://www.cnblogs.com/zzltjnh/p/3885012.html)
