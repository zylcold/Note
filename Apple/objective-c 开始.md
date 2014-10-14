# objective-c 开始

<!-- create time: 2014-09-25 23:19:38  -->

# 更改状态栏的样式(IOS7默认)
* 重写此方法

    UIStatusBarStyle 枚举类型

    objective-c:

        -(UIStatusBarStyle)preferredStatusBarStyle
        {
            return UIStatusBarStyleLightContent;
            //返回一个高亮的状态栏
        }
    
        //隐藏状态栏
        -(BOOL)prefersStatusBarHidden
        {
            return YES;
        }
 
    
#使用系统动画
* 第一种

   objective-c:
    
        [UIView beginAnimations:nil context:nil];//开始动画默认单次，0.2秒
        [UIView setAnimationDuration: 0.2]; // default = 0.2
                  
             //...do something...
  
        [UIView commitAnimations]; //动画终止
    
* 第二种

    objective-c:
    
        [UIView animateWithDuration:0.2 animations:^{
        
            //...do something...
            
        } completion:^(BOOL finished) {
        
            //... do something when end...
            
        }];
        
        
        //动画延时执行 动画2秒，延迟2秒执行，执行速度为匀速
        [UIView animateWithDuration:2 delay:2     
            options:UIViewAnimationOptionCurveLinear animations:^{
            
            //...do something...
        } completion:^(BOOL finished) {
            
            //... do something when end...
        }];
        
        UIViewAnimationOptionCurveLinear //线性匀速
        
        
        
#加载资源清单xxx.plist

   objective-c:
   
          NSBundle *bundle = [NSBundle mainBundle]; //获取bundle
          NSString *path = 
              [bundle pathForResource:@"appList.plist" ofType:nil];
          //获取资源文件全路径 
          //pathForResource:@"appList" ofType:@“plist”   
          NSArray * array = [NSArray arrayWithContentsOfFile:path];
          //将资源清单转化为数组对象   
          
          ==
          
          NSArray * array = [NSArray arrayWithContentsOfFile:
              [[NSBundle mainBundle] pathForResource:@"appList.plist" ofType:nil];
          ]   
          
          
           
#加载资源自定义控件

   objective-c:  
   
    UINib *nib = [UINib nibWithNibName:@"demoView" bundle:nil];
    //bundle 默认为mainbundel 可以填nil
    UIView *view = [[nib instantiateWithOwner:nil options:nil]lastObject];
    
    
    或者
    
    NSBundle * bandle = [NSBundle mainBundle];
    appView* appView = [[bandle loadNibNamed:@"appView" owner:nil 
                options:nil] lastObject];
      
          
          
#设置定时器

##NO.1 GCD

参看[iOS多线程开发（五）---GCD（Grand Central Dispatch）](http://blog.chinaunix.net/uid-24862988-id-3420245.html)

objective-c:


    //C语言中的方法 GCD（Grand Central Dispatch）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 
        (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        //do something...
        
    });
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 
       (int64_t)(<#delayInSeconds#> * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        <#code to be executed after a specified delay#>
        
    });

##NO.2 NSTimer
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



##NO.3 CADisplayLink(快速执行，一秒60帧)

   objective-c:
   
     CADisplayLink * link = [CADisplayLink displayLinkWithTarget:self selector:@selector(nexts)];  //创建link 循环调用self 的nexts方法
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
       //将link添加到mianRunLoop（主）消息循环，为默认的优先级
