# ReactiveCocoa

<!-- create time: 2015-01-29 17:50:01  -->

    ReactiveCocoa是一个将函数响应式编程范例带入Objective-C的开源库。由Josh Abernathy和Justin Spahr-Summers在对GitHub for Mac的开发过程中建立
    
    
##概述

ReactiveCocoa由两大主要部分组成：signals (RACSignal) 和 sequences (RACSequence)。
signal 和 sequence 都是streams，他们共享很多相同的方法。ReactiveCocoa在功能上做了语义丰富、一致性强的一致性设计：signal是push驱动的stream，sequence是pull驱动的stream。

###RACSignal(信号)

* 异步控制或事件驱动的数据源：Cocoa编程中大多数时候会关注用户事件或应用状态改变产生的响应。
* 链式以来操作：网络请求是最常见的依赖性样例，前一个对server的请求完成后，下一个请求才能构建。
* 并行独立动作：独立的数据集要并行处理，随后还要把他们合并成一个最终结果。这在Cocoa中很常见，特别是涉及到同步动作时。

Signal会触发它们的subscriber三种不同类型的事件：


* Steam中的下个(next)事件提供了新的值。RACSteam方法只会在这种类型的事件时执行。不想Cocoa中的collections，在信号中使用nil也是有效的。
* 错误事件(error evenet)表示在信号结束前发生了一个错误。这个事件可能包含了一个NSError对象，指示什么地方除了错误。错误必须得到特殊的处理(handled specially)，因为它们不包含在steam的值中。
* 完成(complete)事件表示信号成功的结束了，并且没有更多的值被添加到steam中。完成后也必须进行特殊处理，原因相同。

一个signal的生命由很多下一个(next)事件和一个错误(error)或完成(completed)事件组成（后两者不同时出现）。


###RACSequence

    简化集合转换：你会痛苦地发现 Foundation 库中没有类似 map 和 filter、fold/reduce 等高级函数。
    
    
   Sequence是一种集合，很像 NSArray。但和数组不同的是，一个sequence里的值默认是延迟加载的（只有需要的时候才加载），这样的话如果sequence只有一部分被用到，那么这种机制就会提高性能。像Cocoa的集合类型一样，sequence不接受 nil 值。
RACSequence 允许任意Cocoa集合在统一且显式地进行操作。

```ObjC

    RACSequence *normalizedLongWords = [[words.rac_sequence
    filter:^ BOOL (NSString *word) {
        return [word length] >= 10;
    }]
    map:^(NSString *word) {
        return [word lowercaseString];
    }];
```


###RACSubject

“可变的（mutable）”信号/自定义信号，它是嫁接非RAC代码到Signals的桥梁

```ObjC

    RACSubject *letters = [RACSubject subject]; 
    RACSignal *signal = [letters sendNext:@"a"]; //将NSString @“a” 加入到Signals中


```


###RACCommand

创建并订阅一个信号以响应一些动作(action)。这使得它很容易处理UI与应用之间的side-effecting work。通常触发command的动作是由UI驱动的，比如按钮的点击。命令也可以根据信号被自动禁用，并且这种禁用状态能过通过禁用任何与command相关的控件来表现在UI上。在OS X上，RAC为NSButton增加了一个rac_command属性来自动设置上述行为(behaviors)。

###RACSequence
RAC世界的NSArray，RAC增加了-rac_sequence方法，可以使诸如NSArray这些集合类（collection classes）直接转换为RACSequence来使用。


###RACScheduler
类似于GCD，but schedulers support cancellationbut schedulers support cancellation, and always execute serially.


##DEMO


###KVO 替代

```ObjC

    //KVO 注册观察者
    [self.loglnButton addObserver:self 
                     forKeyPath:@"selected" 
                         options:NSKeyValueObservingOptionPrior 
                         context:nil];
     //Value改变时调用此方法 observeValueForKeyPath:ofObject:change:context:  
     //注销观察者
     [self.loglnButton removeObserver:self forKeyPath:@"selected"];
     
     


    //RAC 替代
    [RACObserve(self, self.loglnButton.selected) subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];

```


###创建RACSignal


```ObjC


    //通过一个实现RACSubscriber协议的对象，创建signal
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        return nil;
    }];
    
    
    //通过RACObserve创建signal
    RACObserve(self, self.loglnButton.selected)
    
    
    //通过合并多个数据源，创建一个signal
    [RACSignal combineLatest:@[self.textField1.rac_textSignal, self.textField2.rac_textSignal] reduce:^(NSString *text1, NSString *text2){
        return @(text1.length && text2.length);
    }];
    
    
    //通过框架提供的Category，创建signal
    
    UIActionSheet (RACSignalSupport)-> rac_buttonClickedSignal
    UIAlertView (RACSignalSupport) -> rac_buttonClickedSignal, rac_willDismissSignal
    UICollectionReusableView (RACSignalSupport) -> rac_prepareForReuseSignal
    UIControl (RACSignalSupport) -> rac_signalForControlEvents:
    UIGestureRecognizer (RACSignalSupport) -> rac_gestureSignal
    UIImagePickerController (RACSignalSupport) -> rac_imageSelectedSignal
    UITableViewCell (RACSignalSupport) -> rac_prepareForReuseSignal
    UITableViewHeaderFooterView (RACSignalSupport) -> rac_prepareForReuseSignal
    UITextField (RACSignalSupport) -> rac_textSignal
    UITextView (RACSignalSupport) -> rac_textSignal
    
    NSNotificationCenter (RACSupport) -> rac_addObserverForName:object:
    .
    .
    .
    
    
    //通过signal 创建signal
    [RACObserve(self, imageView.image) map:id^(id x){return x ? @YES : @NO}];
    .
    .
    .
      
    
```
