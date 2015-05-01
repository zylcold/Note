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


###常用协议[UIScrollViewDelegate-委托方法API](http://blog.sina.com.cn/s/blog_7b9d64af0101egm8.html)
```(void)scrollViewDidScroll:(UIScrollView *)scrollView``` scrollView滚动时，就调用该方法。任何offset值改变都调用该方法。即滚动过程中，调用多次 

`(void)scrollViewDidZoom:(UIScrollView *)scrollView` 
当scrollView缩放时，调用该方法。在缩放过程中，回多次调用

`(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView`
当开始滚动视图时，执行该方法。一次有效滑动（开始滑动，滑动一小段距离，只要手指不松开，只算一次滑动），只执行一次。

`(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset`
滑动scrollView，并且手指离开时执行。一次有效滑动，只执行一次。
当pagingEnabled属性为YES时，不调用，该方法

`(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate`
滑动视图，当手指离开屏幕那一霎那，调用该方法。一次有效滑动，只执行一次。
decelerate,指代，当我们手指离开那一瞬后，视图是否还将继续向前滚动（一段距离），经过测试，decelerate=YES

`(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView`
滑动减速时调用该方法
该方法在scrollViewDidEndDragging方法之后。

`(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView`
滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。

`(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView`
当滚动视图动画完成后，调用该方法，如果没有动画，那么该方法将不被调用

`(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView`
返回将要缩放的UIView对象。要执行多次

`(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view`
当将要开始缩放时，执行该方法。一次有效缩放，就只执行一次。

`(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale`
当缩放结束后，并且缩放大小回到minimumZoomScale与maximumZoomScale之间后（我们也许会超出缩放范围），调用该方法。

`(BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView`
指示当用户点击状态栏后，滚动视图是否能够滚动到顶部。需要设置滚动视图的属性：_scrollView.scrollsToTop=YES;

`(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView`
当滚动视图滚动到最顶端后，执行该方法


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


