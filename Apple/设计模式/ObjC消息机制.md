# 消息

<!-- create time: 2014-11-11 13:24:04  -->

    Objc是一门动态语言，所以它总是想办法把一些决定工作从编译连接推迟到运行时。也就是说只有编译器是不够的，还需要一个运行时系统 (runtime system) 来执行编译后的代码。这就是 Objective-C Runtime 系统存在的意义，它是整个Objc运行框架的一块基石。
    Objc 从三种不同的层级上与 Runtime 系统进行交互，分别是
    通过 Objective-C 源代码，
    通过 Foundation 框架的NSObject类定义的方法，
    通过对 runtime 函数的直接调用。


##消息
    Objc 中发送消息是用中括号（[]）把接收者和消息括起来，而直到运行时才会把消息与方法实现绑定。

###消息发送的一般步骤:

    id objc_msgSend(id self, SEL op, ...)

1. 检测这个selector 是不是要忽略的。
2. 检测这个 target 是不是 nil 对象。ObjC 的特性是允许对一个 nil 对象执行任何一个方法不会 Crash，因为会被忽略掉。
3. 如果上面两个都过了,那就开始查找这个类的 IMP,先从 cache 里面找,完了找得到就跳到对应的函数去执行。
4. 如果 cache 找不到就找一下方法分发表。
5. 如果分发表找不到就到超类的分发表去找,一直找,直到找到NSObject类为止。
6. 如果还找不到就要开始进入动态方法解析


e.g 动态创建方法

    Person.h
    @interface Person : NSObject
    @property (nonatomic, copy) NSString *name;
    @property (nonatomic, assign) int age;
    @end
    
    Person.m
    @implementation Person
    @dynamic name; //告诉编译器，get/set 方法将动态生成
    
    //重写 resolveInstanceMethod
    + (BOOL)resolveInstanceMethod:(SEL)name
    {
        //判断要求的方法是否是set/get方法
        if (name == @selector(setName:) || name == @selector(name)) {
            // 添加方法，传递参数给dynamicMethodIMP方法
            class_addMethod([self class], name, (IMP)dynamicMethodIMP, "v@:");
            return YES;
        }
        return [super resolveInstanceMethod:name];
    }
    void dynamicMethodIMP(id self, SEL _cmd) {
        NSLog(@"-------<");
    }
    @end
    

    
    
##消息的转发 (暂未整理)
[罗朝辉（飘飘白云）](http://www.cppblog.com/kesalin/archive/2011/08/15/objc_message.html)

[Anewczs 关于Objc动态特性的几个小例子](http://www.swifthumb.com/article-56-1.html)   

[iOS开发 关于SEL的简单总结](http://mobile.51cto.com/hot-431728.htm)

[动态决议](http://www.tekuba.net/program/340/) 

[酷酷的冥王星的技术专栏 Objective C运行时（runtime）技术的几个要点总结](http://www.cnblogs.com/gugupluto/p/3159733.html#aaaaaaaaaaaaaaaaaaa)

[在object-c运行时替换私有类的方法](http://blog.csdn.net/cyforce/article/details/8491033)
    通常，给一个对象发送它不能处理的消息会得到出错提示，然而，Objective-C运行时系统在抛出错误之前，会给消息接收对象发送一条特别的消息forwardInvocation 来通知该对象，该消息的唯一参数是个NSInvocation类型的对象——该对象封装了原始的消息和消息的参数。
    我们可以实现forwardInvocation:方法来对不能处理的消息做一些默认的处理，也可以将消息转发给其他对象来处理，而不抛出错误。
    
    forwardInvocation:方法就像一个不能识别的消息的分发中心，将这些消息转发给不同接收对象。或者它也可以象一个运输站将所有的消息都发送给同一个接收对象。它可以将一个消息翻译成另外一个消息，或者简单的"吃掉“某些消息，因此没有响应也没有错误。forwardInvocation:方法也可以对不同的消息提供同样的响应，这一切都取决于方法的具体实现。该方法所提供是将不同的对象链接到消息链的能力。
    注意： forwardInvocation:方法只有在消息接收对象中无法正常响应消息时才会被调用。 所以，如果我们希望一个对象将negotiate消息转发给其它对象，则这个对象不能有negotiate方法，也不能在动态方法决议中为之提供实现。否则，forwardInvocation:将不可能会被调用。


##objc_setAssociatedObject //设置关联

    
    swift
    func objc_setAssociatedObject(_ object: AnyObject!,
                                     _ key: UnsafePointer<Void>,
                                   _ value: AnyObject!,
                                  _ policy: objc_AssociationPolicy)
   
    OBJECTIVE-C
    void objc_setAssociatedObject ( id object,    //关联对象
                                    const void *key,   //联合值取地址
                                    id value,   //关联值
                                    objc_AssociationPolicy policy ); //关联策略
    
    Sets an associated value for a given object using a given key and association policy.
    设置一个联合值将key与对象通过一种方式关联起来。
    
    

##objc_getAssociatedObject  //取出关联

    SWIFT
    func objc_getAssociatedObject(_ object: AnyObject!,
                                     _ key: UnsafePointer<Void>) -> AnyObject!
    OBJECTIVE-C
    id objc_getAssociatedObject ( id object, const void *key );  //关联对象 //取地址
