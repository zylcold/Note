# UIScrollView

<!-- create time: 2014-09-28 21:06:03  -->

##几个常用属性

```CGPoint``` **contentOffset**;    //default CGPointZero ```滚动的位置```

```CGSize```**contentSize**;      // default CGSizeZero  ```ScrollView滚动范围```

```UIEdgeInsets```**contentInset**;    ```额外的滚动范围```

```BOOL``` **showsHorizontalScrollIndicator**; // default YES. ```水平滚动条显示```

```BOOL``` **showsVerticalScrollIndicator**; // default YES. ```垂直滚动条显示```

```BOOL``` **pagingEnabled**;    // default NO.     ```是否分页(以scroll宽度为准)```



##监听ScrollView --> 通过代理模式监听对其的操作，通常代理的对象为控制器

成为代理对象的条件

1. 遵循相应控件的协议  -->在其声明后加响应的空间协议
2. 通过属性设置给控制器的对象  -->控制器对象.delegate = self;


成为代理对象后，每当对控制器产生相应的操作，控制器就将通过协议，调用代理对象中已经实现的方法。

协议中@optional @end 内的为可选方法。


###常用协议
```UIView```**viewForZoomingInScrollView**; 控件的放大缩小操作（单一控件）

```void```**scrollViewDidScroll**;正在滚动

```void```**scrollViewDidEndDragging**;结束滚动

```void```**scrollViewWillBeginDragging**;开始滚动


## 计时器

(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;

通过类方法创建一个计时器。

* NSTimer 返回值类型
* NSTimeInterval 设置时间秒
* id 执行的对象
* SEL 调用的方法
* id 方法对应的参数
* BOOL 是否循环执行

- (void)invalidate;  停止计时器，计时器一旦停止，不能重新打开，只能重新创建计时器。

(instancetype)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)ti target:(id)t selector:(SEL)s userInfo:(id)ui repeats:(BOOL)rep NS_DESIGNATED_INITIALIZER;

通过对象的方法创建计时器，此计时器必须通过- (void)fire; 激活。

### 设置计时器的线程优先级

[[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

默认Mode 为NSDefaultRunLoopMode；

通过以上方法可以实现一个图片轮播器。


