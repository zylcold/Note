# (对象关联或关联引用)Associated Objects

<!-- create time: 2014-12-23 17:17:35  -->

[Associated Objects](http://nshipster.cn/associated-objects/)


    对象关联（或称为关联引用）本来是Objective-C 2.0运行时的一个特性，起始于OS X Snow Leopard和iOS 4。相关参考可以查看 <objc/runtime.h> 中定义的以下三个允许你将任何键值在运行时关联到对象上的函数：

    objc_setAssociatedObject  //设置
    objc_getAssociatedObject  //获取
    objc_removeAssociatedObjects   //

    为什么我说这个很有用呢？因为这允许开发者对已经存在的类在扩展中添加自定义的属性，这几乎弥补了Objective-C最大的缺点。


##向NSObject类别添加属性

    NSObject+AssociatedObject.h
    @interface NSObject (AssociatedObject)
    @property (nonatomic, strong) id associatedObject;
    @end
    
    
    NSObject+AssociatedObject.m
    @implementation NSObject (AssociatedObject)
    @dynamic associatedObject;
    - (void)setAssociatedObject:(id)object {
        objc_setAssociatedObject(self, @selector(associatedObject), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    - (id)associatedObject {
        return objc_getAssociatedObject(self, @selector(associatedObject));
    }
    通常推荐的做法是添加的属性最好是 static char 类型的，当然更推荐是指针型的。通常来说该属性应该是常量、唯一的、在适用范围内用getter和setter访问到：
    static char kAssociatedObjectKey;
    objc_getAssociatedObject(self, &kAssociatedObjectKey);
    
    然而可以用更简单的方式实现：用selector。如上例。
    
    Since SELs are guaranteed to be unique and constant, you can use _cmd as the key for objc_setAssociatedObject(). －－－— Bill Bumgarner
    
###关联对象的行为


Behavior                         | @property Equivalent  | Description
---------------------------------|-----------------------|--------------
OBJC_ASSOCIATION_ASSIGN         |(assign/unsafe_unretained)| 指定一个关联对象的弱引用。
OBJC_ASSOCIATION_RETAIN_NONATOMIC|(nonatomic, strong)    | 指定一个关联对象的强引用，不能被原子化使用。
OBJC_ASSOCIATION_COPY_NONATOMIC	  |(nonatomic, copy)  | 指定一个关联对象的copy引用，不能被原子化使用。
OBJC_ASSOCIATION_RETAIN	          |(atomic, strong)   | 指定一个关联对象的强引用，能被原子化使用。
OBJC_ASSOCIATION_COPY	          |(atomic, copy)     | 指定一个关联对象的copy引用，能被原子化使用。


    以 OBJC_ASSOCIATION_ASSIGN 类型关联在对象上的弱引用不代表0 retian的 weak 弱引用，行为上更像 unsafe_unretained 属性，所以当在你的视线中调用weak的关联对象时要相当小心。

> 根据WWDC 2011, Session 322 (第36分钟左右)发布的内存销毁时间表，被关联的对象在生命周期内要比对象本身释放的晚很> 多。它们会在被 NSObject -dealloc 调用的 object_dispose() 方法中释放。


###删除属性

    你可以会在刚开始接触对象关联时想要尝试去调用 objc_removeAssociatedObjects() 来进行删除操作，但如文档中所述，你不应该自己手动调用这个函数：

> 此函数的主要目的是在“初试状态”时方便地返回一个对象。你不应该用这个函数来删除对象的属性，因为可能会导致其他客户对其添加的属性也被移除了。规范的方法是：调用 objc_setAssociatedObject 方法并传入一个 nil 值来清除一个关联。


##优秀样例

1. ``添加私有属性用于更好地去实现细节。``当扩展一个内建类的行为时，保持附加属性的状态可能非常必要。注意以下说的是一种非常教科书式的关联对象的用例：AFNetworking在 UIImageView 的category上用了关联对象来保持一个operation对象，用于从网络上某URL异步地获取一张图片。
2. ``添加public属性来增强category的功能。``有些情况下这种(通过关联对象)让category行为更灵活的做法比在用一个带变量的方法来实现更有意义。在这些情况下，可以用关联对象实现一个一个对外开放的属性。回到上个AFNetworking的例子中的 UIImageView category，它的 imageResponseSerializer方法允许图片通过一个滤镜来显示、或在缓存到硬盘之前改变图片的内容。
3. ``创建一个用于KVO的关联观察者。``当在一个category的实现中使用KVO时，建议用一个自定义的关联对象而不是该对象本身作观察者。ng an associated observer for KVO**. When using KVO in a category implementation, it is recommended that a custom associated-object be used as an observer, rather than the object observing itself.
反例

1. ``当值不需要的时候建立一个关联对象。``一个常见的例子就是在view上创建一个方便的方法去保存来自model的属性、值或者其他混合的数据。如果那个数据在之后根本用不到，那么这种方法虽然是没什么问题的，但用关联到对象的做法并不可取。
当一个值可以被其他值推算出时建立一个关联对象。例如：在调用 cellForRowAtIndexPath: 时存储一个指向view的 UITableViewCell 中accessory view的引用，用于在 tableView:accessoryButtonTappedForRowWithIndexPath: 中使用。
2. 用关联对象替代X，这里的X可以代表下列含义：

        当继承比扩展原有的类更方便时用子类化。
        为事件的响应者添加响应动作。
        当响应动作不方便使用时使用的手势动作捕捉。
        行为可以在其他对象中被代理实现时要用代理(delegate)。
        用NSNotification 和 NSNotificationCenter进行松耦合化的跨系统的事件通知。 * * *

比起其他解决问题的方法，关联对象应该被视为最后的选择（事实上category也不应该作为首选方法）。
